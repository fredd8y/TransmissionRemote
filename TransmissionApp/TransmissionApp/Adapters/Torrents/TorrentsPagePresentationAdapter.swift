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
		UserDefaultsHandler.shared.currentServerPublisher.dropFirst().sink { [weak self] _ in
			self?.torrentsPageViewModel.newValues(TorrentsPageViewModel.loading())
		}.store(in: &currentServerCancellable)
	}
	
	private var workItems: [DispatchWorkItem] = []
	private var cancellables = Set<AnyCancellable>()
	private var pollingRateCancellable = Set<AnyCancellable>()
	private var currentServerCancellable = Set<AnyCancellable>()
	
	private var sessionIdHandler: (String) -> Void
	
	@ObservedObject var torrentsPageViewModel: TorrentsPageViewModel
	
	func start(_ id: Int) {
		guard let server = UserDefaultsHandler.shared.currentServer else {
			torrentsPageViewModel.alertMessage = TorrentsPagePresenter.missingServerError
			torrentsPageViewModel.alertMessageVisible = true
			return
		}
		TorrentStartPublishers.makeTorrentStartPublisher(server: server, id: id)
		.dispatchOnMainQueue()
		.sink(
			receiveCompletion: { [weak self] completion in
				switch completion {
				case .finished: break
				case .failure(let error):
					if let _error = error as? TorrentStartMapper.Error {
						switch _error {
						case .failed(let explanation):
							self?.torrentsPageViewModel.alertMessage = explanation
							self?.torrentsPageViewModel.alertMessageVisible = true
						case .invalidData:
							self?.torrentsPageViewModel.alertMessage = TorrentsPagePresenter.genericError
							self?.torrentsPageViewModel.alertMessageVisible = true
						}
					}
				}
			},
			receiveValue: { [weak self] _ in
				self?.loadData()
			}
		).store(in: &cancellables)
	}
	
	func startAll() {
		guard let server = UserDefaultsHandler.shared.currentServer else {
			torrentsPageViewModel.alertMessage = TorrentsPagePresenter.missingServerError
			torrentsPageViewModel.alertMessageVisible = true
			return
		}
		TorrentStartPublishers.makeTorrentStartAllPublisher(server: server)
			.dispatchOnMainQueue()
			.sink(
				receiveCompletion: { [weak self] completion in
					switch completion {
					case .finished: break
					case .failure(let error):
						if let _error = error as? TorrentStartMapper.Error {
							switch _error {
							case .failed(let explanation):
								self?.torrentsPageViewModel.alertMessage = explanation
								self?.torrentsPageViewModel.alertMessageVisible = true
							case .invalidData:
								self?.torrentsPageViewModel.alertMessage = TorrentsPagePresenter.genericError
								self?.torrentsPageViewModel.alertMessageVisible = true
							}
						}
					}
				},
				receiveValue: { [weak self] _ in
					self?.loadData()
				}
			).store(in: &cancellables)
	}
	
	func stop(_ id: Int) {
		guard let server = UserDefaultsHandler.shared.currentServer else {
			torrentsPageViewModel.alertMessage = TorrentsPagePresenter.missingServerError
			torrentsPageViewModel.alertMessageVisible = true
			return
		}
		TorrentStopPublishers.makeTorrentStopPublisher(server: server, id: id)
		.dispatchOnMainQueue()
		.sink(
			receiveCompletion: { [weak self] completion in
				switch completion {
				case .finished: break
				case .failure(let error):
					if let _error = error as? TorrentStopMapper.Error {
						switch _error {
						case .failed(let explanation):
							self?.torrentsPageViewModel.alertMessage = explanation
							self?.torrentsPageViewModel.alertMessageVisible = true
						case .invalidData:
							self?.torrentsPageViewModel.alertMessage = TorrentsPagePresenter.genericError
							self?.torrentsPageViewModel.alertMessageVisible = true
						}
					}
				}
			},
			receiveValue: { [weak self] _ in
				self?.loadData()
			}
		).store(in: &cancellables)
	}
	
	func stopAll() {
		guard let server = UserDefaultsHandler.shared.currentServer else {
			torrentsPageViewModel.alertMessage = TorrentsPagePresenter.missingServerError
			torrentsPageViewModel.alertMessageVisible = true
			return
		}
		TorrentStopPublishers.makeTorrentStopAllPublisher(server: server)
		.dispatchOnMainQueue()
		.sink(
			receiveCompletion: { [weak self] completion in
				switch completion {
				case .finished: break
				case .failure(let error):
					if let _error = error as? TorrentStopMapper.Error {
						switch _error {
						case .failed(let explanation):
							self?.torrentsPageViewModel.alertMessage = explanation
							self?.torrentsPageViewModel.alertMessageVisible = true
						case .invalidData:
							self?.torrentsPageViewModel.alertMessage = TorrentsPagePresenter.genericError
							self?.torrentsPageViewModel.alertMessageVisible = true
						}
					}
				}
			},
			receiveValue: { [weak self] _ in
				self?.loadData()
			}
		).store(in: &cancellables)
	}
	
	func selectedLink(_ link: String) {
		guard let server = UserDefaultsHandler.shared.currentServer else {
			torrentsPageViewModel.alertMessage = TorrentsPagePresenter.missingServerError
			torrentsPageViewModel.alertMessageVisible = true
			return
		}
		TorrentAddPublishers.makeLinkAddPublisher(
			server: server,
			startWhenAdded: true,
			link: link
		)
		.dispatchOnMainQueue()
		.sink(
			receiveCompletion: { [weak self] completion in
				switch completion {
				case .finished: break
				case .failure(let error):
					if let _error = error as? TorrentAddMapper.Error {
						switch _error {
						case .failed(let explanation):
							self?.torrentsPageViewModel.alertMessage = explanation
							self?.torrentsPageViewModel.alertMessageVisible = true
						case .torrentDuplicate(let name):
							self?.torrentsPageViewModel.alertMessage = "\(name) \(TorrentsPagePresenter.itemAlreadyAdded)"
							self?.torrentsPageViewModel.alertMessageVisible = true
						case .invalidData:
							self?.torrentsPageViewModel.alertMessage = TorrentsPagePresenter.genericError
							self?.torrentsPageViewModel.alertMessageVisible = true
						}
					}
				}
			},
			receiveValue: { [weak self] _ in
				self?.loadData()
			}
		).store(in: &cancellables)
	}
	
	func selectedFile(_ url: URL) {
		guard let server = UserDefaultsHandler.shared.currentServer else {
			torrentsPageViewModel.alertMessage = TorrentsPagePresenter.missingServerError
			torrentsPageViewModel.alertMessageVisible = true
			return
		}
		guard url.startAccessingSecurityScopedResource() else {
			torrentsPageViewModel.alertMessage = TorrentsPagePresenter.filePermissionError
			torrentsPageViewModel.alertMessageVisible = true
			return
		}
		TorrentAddPublishers.makeTorrentAddPublisher(
			server: server,
			startWhenAdded: true,
			torrentFilePath: url.absoluteString
		)
		.dispatchOnMainQueue()
		.sink(
			receiveCompletion: { [weak self] completion in
				switch completion {
				case .finished:
					url.stopAccessingSecurityScopedResource()
				case .failure(let error):
					url.stopAccessingSecurityScopedResource()
					if let _error = error as? TorrentAddMapper.Error {
						switch _error {
						case .failed(let explanation):
							self?.torrentsPageViewModel.alertMessage = explanation
							self?.torrentsPageViewModel.alertMessageVisible = true
						case .torrentDuplicate(let name):
							self?.torrentsPageViewModel.alertMessage = "\(name) \(TorrentsPagePresenter.itemAlreadyAdded)"
							self?.torrentsPageViewModel.alertMessageVisible = true
						case .invalidData:
							self?.torrentsPageViewModel.alertMessage = TorrentsPagePresenter.genericError
							self?.torrentsPageViewModel.alertMessageVisible = true
						}
					}
				}
			},
			receiveValue: { [weak self] _ in
				self?.loadData()
			}
		).store(in: &cancellables)
	}
	
	func delete(_ id: Int, _ deleteLocalData: Bool) {
		guard let server = UserDefaultsHandler.shared.currentServer else {
			torrentsPageViewModel.alertMessage = TorrentsPagePresenter.missingServerError
			torrentsPageViewModel.alertMessageVisible = true
			return
		}
		TorrentRemovePublishers.makeTorrentRemovePublisher(
			server: server,
			id: id,
			deleteLocalData: deleteLocalData
		)
		.dispatchOnMainQueue()
		.sink(
			receiveCompletion: { [weak self] completion in
				switch completion {
				case .finished: break
				case .failure(let error):
					if let _error = error as? TorrentRemoveMapper.Error {
						switch _error {
						case .failed(let explanation):
							self?.torrentsPageViewModel.alertMessage = explanation
							self?.torrentsPageViewModel.alertMessageVisible = true
						case .invalidData:
							self?.torrentsPageViewModel.alertMessage = TorrentsPagePresenter.genericError
							self?.torrentsPageViewModel.alertMessageVisible = true
						}
					}
				}
			},
			receiveValue: { [weak self] _ in
				self?.loadData()
			}
		).store(in: &cancellables)
	}
	
	func deleteAll(_ deleteLocalData: Bool) {
		guard let server = UserDefaultsHandler.shared.currentServer else {
			torrentsPageViewModel.alertMessage = TorrentsPagePresenter.missingServerError
			torrentsPageViewModel.alertMessageVisible = true
			return
		}
		TorrentRemovePublishers.makeTorrentRemoveAllPublisher(
			server: server,
			deleteLocalData: deleteLocalData
		)
		.dispatchOnMainQueue()
		.sink(
			receiveCompletion: { [weak self] completion in
				switch completion {
				case .finished: break
				case .failure(let error):
					if let _error = error as? TorrentRemoveMapper.Error {
						switch _error {
						case .failed(let explanation):
							self?.torrentsPageViewModel.alertMessage = explanation
							self?.torrentsPageViewModel.alertMessageVisible = true
						case .invalidData:
							self?.torrentsPageViewModel.alertMessage = TorrentsPagePresenter.genericError
							self?.torrentsPageViewModel.alertMessageVisible = true
						}
					}
				}
			},
			receiveValue: { [weak self] _ in
				self?.loadData()
			}
		).store(in: &cancellables)
	}
	
	func setDownloadLimit(_ enabled: Bool) {
		guard let server = UserDefaultsHandler.shared.currentServer else {
			torrentsPageViewModel.alertMessage = TorrentsPagePresenter.missingServerError
			torrentsPageViewModel.alertMessageVisible = true
			return
		}
		SessionSettingsPublishers.makeSetDownloadLimitEnabled(
			enabled: enabled,
			server: server
		)
		.dispatchOnMainQueue()
		.sink(
			receiveCompletion: { [weak self] completion in
				switch completion {
				case .finished: break
				case .failure(let error):
					if let _error = error as? SessionSetMapper.Error {
						switch _error {
						case .failed(let explanation):
							self?.torrentsPageViewModel.alertMessage = explanation
							self?.torrentsPageViewModel.alertMessageVisible = true
						case .invalidData:
							self?.torrentsPageViewModel.alertMessage = TorrentsPagePresenter.genericError
							self?.torrentsPageViewModel.alertMessageVisible = true
						}
					}
				}
			},
			receiveValue: { [weak self] _ in
				self?.loadData()
			}
		).store(in: &cancellables)
	}
	
	func stopLoadingData() {
		cancelCurrentLoadingTasks()
	}
	
	func loadData() {
		cancelCurrentLoadingTasks()
		guard let server = UserDefaultsHandler.shared.currentServer else {
			torrentsPageViewModel.newValues(TorrentsPageViewModel.serverNotSet())
			return
		}
		TorrentLoadPublishers.makeRemoteTorrentsLoader(server: server)
		.dispatchOnMainQueue()
		.sink(
			receiveCompletion: { [weak self] completion in
				switch completion {
				case .finished: break
				case let .failure(error):
                    switch error {
                    case let error as SessionGetMapper.Error:
                        switch error {
                        case .failed(let explanation):
                            self?.torrentsPageViewModel.alertMessage = explanation
                            self?.torrentsPageViewModel.alertMessageVisible = true
                        case .invalidData:
                            self?.torrentsPageViewModel.newValues(TorrentsPageViewModel.error())
                        }
					case let error as AuthenticationError:
						switch error {
						case .authenticationFailed:
							self?.torrentsPageViewModel.newValues(TorrentsPageViewModel.credentialRequired())
						case .missingSessionId(let sessionId):
							guard let _sessionId = sessionId else { break }
							self?.sessionIdHandler(_sessionId)
							self?.loadData()
						}
                    case let error as NetworkError:
                        switch error {
                        case .unknownError:
                            self?.torrentsPageViewModel.newValues(TorrentsPageViewModel.error())
                        case .serverTimeout:
                            self?.torrentsPageViewModel.newValues(TorrentsPageViewModel.serverTimeout())
						case .serverUnreachable:
							self?.torrentsPageViewModel.newValues(TorrentsPageViewModel.serverUnreachable())
                        case .connectionUnavailable:
                            self?.torrentsPageViewModel.newValues(TorrentsPageViewModel.connectionUnavailable())
                        }
                    default:
                        break
                    }
				}
			},
			receiveValue: { [weak self] (session, torrents) in
				let viewModel = TorrentsPagePresenter.map(
					title: TorrentsPagePresenter.title,
					isLoading: false,
					error: nil,
					uploadSpeed: torrents.reduce(0) { $0 + $1.rateUpload },
					downloadSpeed: torrents.reduce(0) { $0 + $1.rateDownload },
					temporaryUploadSpeed: session.altSpeedUp,
					temporaryDownloadSpeed: session.altSpeedDown,
					temporarySpeedEnabled: session.altSpeedEnabled,
					torrents: torrents,
					freeDiskSpace: session.downloadDirFreeSpace,
					emptyMessage: torrents.count > 0 ? nil : TorrentsPagePresenter.emptyTorrentListMessage,
					canAddTorrent: true,
					alertMessage: nil,
					alertMessageVisible: false
				)
				self?.torrentsPageViewModel.newValues(viewModel)
				let workItem = DispatchWorkItem { [weak self] in
					self?.loadData()
				}
				self?.workItems.append(workItem)
				DispatchQueue.main.asyncAfter(deadline: .now() + DispatchTimeInterval.seconds(UserDefaultsHandler.shared.pollingRate), execute: workItem)
			}
		).store(in: &cancellables)
	}
	
	private func cancelCurrentLoadingTasks() {
		workItems.forEach { $0.cancel() }
		workItems.removeAll()
		cancellables.removeAll()
	}
}

private extension TorrentsPageViewModel {
	func newValues(_ viewModel: TorrentsPageViewModel) {
		title = viewModel.title
		isLoading = viewModel.isLoading
		error = viewModel.error
		uploadSpeed = viewModel.uploadSpeed
		downloadSpeed = viewModel.downloadSpeed
		temporaryUploadSpeed = viewModel.temporaryUploadSpeed
		temporaryDownloadSpeed = viewModel.temporaryDownloadSpeed
		temporarySpeedEnabled = viewModel.temporarySpeedEnabled
		torrents = viewModel.torrents
		freeDiskSpace = viewModel.freeDiskSpace
		emptyMessage = viewModel.emptyMessage
		canAddTorrent = viewModel.canAddTorrent
	}
}
