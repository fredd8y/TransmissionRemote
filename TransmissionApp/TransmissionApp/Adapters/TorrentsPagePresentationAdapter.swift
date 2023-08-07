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
		torrentsPageViewModel: TorrentsViewModel,
		server: Server?,
		sessionIdHandler: @escaping (String) -> Void
	) {
		self.torrentsPageViewModel = torrentsPageViewModel
		self.server = server
		self.sessionIdHandler = sessionIdHandler
		pollingRateCancellable = UserDefaultsHandler.shared.$pollingRate.sink { [weak self] newValue in
			guard let self else { return }
			self.timer.invalidate()
			self.timer = self.createTimer(newValue)
			self.timer.fire()
		}
	}
	
	private lazy var timer = createTimer(UserDefaultsHandler.shared.pollingRate)
	
	private lazy var createTimer: (Int) -> Timer = { [weak self] pollingRate in
		Timer.scheduledTimer(withTimeInterval: TimeInterval(pollingRate), repeats: true) { _ in
			self?.sessionLoaderCancellable?.cancel()
			self?.loadData()
		}
	}
	
	private var pollingRateCancellable: Cancellable?
	private var sessionLoaderCancellable: Cancellable?
	private var server: Server?
	private var sessionIdHandler: (String) -> Void

	@ObservedObject var torrentsPageViewModel: TorrentsViewModel

	func loadData() {
		guard let server else {
			torrentsPageViewModel.newValues(TorrentsViewModel.serverNotSet())
			return
		}
		sessionLoaderCancellable = TransmissionHTTPClient.makeRemoteSessionLoader(server: server)
			.dispatchOnMainQueue()
			.sink(
				receiveCompletion: { [weak self] completion in
					switch completion {
					case .finished:
						break
					case let .failure(error):
						guard let _error = error as? SessionGetMapper.Error else {
							self?.torrentsPageViewModel.newValues(TorrentsViewModel.error())
							return
						}
						switch _error {
						case .authenticationFailed:
							self?.torrentsPageViewModel.showAlert = true
						case let .missingSessionId(sessionId):
							guard let _sessionId = sessionId as? String else {
								// TODO: Handle error
								break
							}
							self?.sessionIdHandler(_sessionId)
							self?.loadData()
						case .invalidData:
							self?.torrentsPageViewModel.newValues(TorrentsViewModel.error())
						}
					}
				},
				receiveValue: { [weak self] session in
					self?.sessionLoaderCancellable = TransmissionHTTPClient.makeRemoteTorrentsLoader(server: server)
						.dispatchOnMainQueue()
						.sink(
							receiveCompletion: { completion in
								switch completion {
								case .finished: break
								case .failure:
									self?.torrentsPageViewModel.newValues(TorrentsViewModel.error())
								}
							},
							receiveValue: { torrents in
								let viewModel = TorrentsPresenter.map(
									title: TorrentsPresenter.title,
									error: nil,
									uploadSpeed: torrents.reduce(0) { $0 + $1.rateUpload },
									downloadSpeed: torrents.reduce(0) { $0 + $1.rateDownload },
									torrents: torrents,
									emptyMessage: nil
								)
								self?.torrentsPageViewModel.newValues(viewModel)
								self?.timer.fireIfInvalid()
							}
						)
				}
			)
	}
}

private extension TorrentsViewModel {
	func newValues(_ viewModel: TorrentsViewModel) {
		title = viewModel.title
		error = viewModel.error
		uploadSpeed = viewModel.uploadSpeed
		downloadSpeed = viewModel.downloadSpeed
		torrents = viewModel.torrents
		showAlert = viewModel.showAlert
		emptyMessage = viewModel.emptyMessage
	}
}

private extension Timer {
	func fireIfInvalid() {
		if !isValid { fire() }
	}
}
