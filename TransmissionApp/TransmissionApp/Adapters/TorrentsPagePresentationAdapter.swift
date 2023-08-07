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
		pollingRateCancellable = UserDefaultsHandler.shared.$pollingRate.sink { [weak self] newValue in
			self?.sessionLoaderCancellable?.cancel()
			self?.loadData(server: UserDefaultsHandler.shared.currentServer)
		}
		currentServerCancellable = UserDefaultsHandler.shared.$currentServer.sink { [weak self] newValue in
			self?.sessionLoaderCancellable?.cancel()
			self?.torrentsPageViewModel.newValues(TorrentsPageViewModel.empty())
			self?.loadData(server: newValue)
		}
	}
	
	private var pollingRateCancellable: Cancellable?
	private var currentServerCancellable: Cancellable?
	private var sessionLoaderCancellable: Cancellable?
	
	private var sessionIdHandler: (String) -> Void

	@ObservedObject var torrentsPageViewModel: TorrentsPageViewModel
	
	func loadData(server: Server?) {
		guard let server else {
			torrentsPageViewModel.newValues(TorrentsPageViewModel.serverNotSet())
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
							self?.torrentsPageViewModel.newValues(TorrentsPageViewModel.error())
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
							self?.loadData(server: server)
						case .invalidData:
							self?.torrentsPageViewModel.newValues(TorrentsPageViewModel.error())
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
									self?.torrentsPageViewModel.newValues(TorrentsPageViewModel.error())
								}
							},
							receiveValue: { torrents in
								let viewModel = TorrentsPagePresenter.map(
									title: TorrentsPagePresenter.title,
									error: nil,
									uploadSpeed: torrents.reduce(0) { $0 + $1.rateUpload },
									downloadSpeed: torrents.reduce(0) { $0 + $1.rateDownload },
									torrents: torrents,
									emptyMessage: nil
								)
								self?.torrentsPageViewModel.newValues(viewModel)
								DispatchQueue.main.asyncAfter(deadline: .now() + DispatchTimeInterval.seconds(UserDefaultsHandler.shared.pollingRate)) {
									self?.loadData(server: server)
								}
							}
						)
				}
			)
	}
}

private extension TorrentsPageViewModel {
	func newValues(_ viewModel: TorrentsPageViewModel) {
		title = viewModel.title
		error = viewModel.error
		uploadSpeed = viewModel.uploadSpeed
		downloadSpeed = viewModel.downloadSpeed
		torrents = viewModel.torrents
		showAlert = viewModel.showAlert
		emptyMessage = viewModel.emptyMessage
	}
}
