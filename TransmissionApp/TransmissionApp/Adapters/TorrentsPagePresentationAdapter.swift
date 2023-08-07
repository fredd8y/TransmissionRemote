//
//  TorrentsPagePresentationAdapter.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 24/07/23.
//

import Combine
import SwiftUI
import Transmission
import TransmissioniOS

final class TorrentsPagePresentationAdapter {
	// MARK: Lifecycle

	init(
		torrentsPageViewModel: TorrentsPageViewModel,
		sessionIdHandler: @escaping (String) -> Void
	) {
		self.torrentsPageViewModel = torrentsPageViewModel
		self.sessionIdHandler = sessionIdHandler
		UserDefaultsHandler.shared.$pollingRate.sink { [weak self] newValue in
			self?.resetTimer(server: UserDefaultsHandler.shared.currentServer, timeInterval: TimeInterval(newValue))
		}.store(in: &pollingRateCancellable)
		UserDefaultsHandler.shared.$currentServer.sink { [weak self] newValue in
			self?.torrentsPageViewModel.newValues(TorrentsPageViewModel.empty())
			self?.resetTimer(server: newValue, timeInterval: TimeInterval(UserDefaultsHandler.shared.pollingRate))
		}.store(in: &currentServerCancellable)
		resetTimer(
			server: UserDefaultsHandler.shared.currentServer,
			timeInterval: TimeInterval(UserDefaultsHandler.shared.pollingRate)
		)
	}
	
	private func resetTimer(server: Server?, timeInterval: TimeInterval) {
		timer?.invalidate()
		cancellables.removeAll()
		timer = createTimer(server: server, timerInterval: timeInterval)
		timer?.fire()
	}
	
	private var cancellables = Set<AnyCancellable>()
	private var pollingRateCancellable = Set<AnyCancellable>()
	private var currentServerCancellable = Set<AnyCancellable>()
	private var addTorrentCancellable = Set<AnyCancellable>()
	
	private var sessionIdHandler: (String) -> Void
	
	private var timer: Timer?
	
	private func createTimer(server: Server?, timerInterval: TimeInterval) -> Timer {
		Timer.scheduledTimer(withTimeInterval: timerInterval, repeats: true) { [weak self] _ in
			self?.cancellables.removeAll()
			self?.loadData(server: server)
		}
	}

	@ObservedObject var torrentsPageViewModel: TorrentsPageViewModel
	
	func selectedFile(_ url: URL) {
		guard let server = UserDefaultsHandler.shared.currentServer else {
			// TODO: handle error
			return
		}
		do {
			try TransmissionHTTPClient.makeTorrentAddPublisher(
				server: server,
				startWhenAdded: true,
				downloadDir: "",
				torrentFilePath: url.absoluteString
			)
			.dispatchOnMainQueue()
			.sink(
				receiveCompletion: { completion in
					switch completion {
					case .finished: break
					case .failure:
						//TODO: Show error in torrents page
						break
					}
				},
				receiveValue: { _ in }
			).store(in: &addTorrentCancellable)
		} catch {
			// TODO: handle error
		}
	}
	
	func loadData(server: Server?) {
		guard let server else {
			torrentsPageViewModel.newValues(TorrentsPageViewModel.serverNotSet())
			return
		}
		Publishers.Zip(
			TransmissionHTTPClient.makeRemoteSessionLoader(server: server),
			TransmissionHTTPClient.makeRemoteTorrentsLoader(server: server)
		)
		.dispatchOnMainQueue()
		.sink(
			receiveCompletion: { [weak self] completion in
				switch completion {
				case .finished:
					break
				case let .failure(error):
					if let _error = error as? SessionGetMapper.Error {
						switch _error {
						case .authenticationFailed:
							self?.torrentsPageViewModel.newValues(TorrentsPageViewModel.credentialRequired())
							self?.timer?.invalidate()
						case let .missingSessionId(sessionId):
							guard let _sessionId = sessionId as? String else {
								// TODO: Handle error
								break
							}
							self?.sessionIdHandler(_sessionId)
							self?.resetTimer(server: server, timeInterval: TimeInterval(UserDefaultsHandler.shared.pollingRate))
						case .invalidData:
							self?.torrentsPageViewModel.newValues(TorrentsPageViewModel.error())
						}
					}
				}
			},
			receiveValue: { (_, torrents) in
				let viewModel = TorrentsPagePresenter.map(
					title: TorrentsPagePresenter.title,
					error: nil,
					uploadSpeed: torrents.reduce(0) { $0 + $1.rateUpload },
					downloadSpeed: torrents.reduce(0) { $0 + $1.rateDownload },
					torrents: torrents,
					emptyMessage: nil
				)
				self.torrentsPageViewModel.newValues(viewModel)
			}
		).store(in: &cancellables)
	}
}

private extension TorrentsPageViewModel {
	func newValues(_ viewModel: TorrentsPageViewModel) {
		title = viewModel.title
		error = viewModel.error
		uploadSpeed = viewModel.uploadSpeed
		downloadSpeed = viewModel.downloadSpeed
		torrents = viewModel.torrents
		emptyMessage = viewModel.emptyMessage
	}
}
