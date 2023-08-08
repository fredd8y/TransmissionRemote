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
		UserDefaultsHandler.shared.pollingRatePublisher.sink { [weak self] _ in
			self?.loadData()
		}.store(in: &pollingRateCancellable)
		UserDefaultsHandler.shared.currentServerPublisher.dropFirst().sink { [weak self] _ in
			self?.torrentsPageViewModel.newValues(TorrentsPageViewModel.loading())
			self?.cancellables.removeAll()
			self?.loadData()
		}.store(in: &currentServerCancellable)
	}
	
	
	private var cancellables = Set<AnyCancellable>()
	private var addTorrentCancellable = Set<AnyCancellable>()
	private var stopTorrentCancellable = Set<AnyCancellable>()
	private var pollingRateCancellable = Set<AnyCancellable>()
	private var startTorrentCancellable = Set<AnyCancellable>()
	private var currentServerCancellable = Set<AnyCancellable>()
	private var deleteTorrentCancellable = Set<AnyCancellable>()
	
	private var sessionIdHandler: (String) -> Void
	
	@ObservedObject var torrentsPageViewModel: TorrentsPageViewModel
	
	func start(_ id: Int) {
		guard let server = UserDefaultsHandler.shared.currentServer else {
			torrentsPageViewModel.alertMessage = TorrentsPagePresenter.missingServerError
			torrentsPageViewModel.alertMessageVisible = true
			return
		}
		TransmissionHTTPClient.makeTorrentStartPublisher(server: server, id: id)
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
		).store(in: &stopTorrentCancellable)
	}
	func stop(_ id: Int) {
		guard let server = UserDefaultsHandler.shared.currentServer else {
			torrentsPageViewModel.alertMessage = TorrentsPagePresenter.missingServerError
			torrentsPageViewModel.alertMessageVisible = true
			return
		}
		TransmissionHTTPClient.makeTorrentStopPublisher(server: server, id: id)
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
		).store(in: &stopTorrentCancellable)
	}
	
	func selectedLink(_ link: String) {
		guard let server = UserDefaultsHandler.shared.currentServer else {
			torrentsPageViewModel.alertMessage = TorrentsPagePresenter.missingServerError
			torrentsPageViewModel.alertMessageVisible = true
			return
		}
		TransmissionHTTPClient.makeLinkAddPublisher(
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
		).store(in: &addTorrentCancellable)
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
		TransmissionHTTPClient.makeTorrentAddPublisher(
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
		).store(in: &addTorrentCancellable)
	}
	
	func delete(_ id: Int, _ deleteLocalData: Bool) {
		guard let server = UserDefaultsHandler.shared.currentServer else {
			torrentsPageViewModel.alertMessage = TorrentsPagePresenter.missingServerError
			torrentsPageViewModel.alertMessageVisible = true
			return
		}
		TransmissionHTTPClient.makeTorrentRemovePublisher(
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
		).store(in: &deleteTorrentCancellable)
	}
	
	func loadData() {
		guard let server = UserDefaultsHandler.shared.currentServer else {
			torrentsPageViewModel.newValues(TorrentsPageViewModel.serverNotSet())
			return
		}
		var cancellable: AnyCancellable?
		cancellable = TransmissionHTTPClient.makeRemoteTorrentsLoader(server: server)
		.dispatchOnMainQueue()
		.sink(
			receiveCompletion: { [weak self] completion in
				switch completion {
				case .finished: break
				case let .failure(error):
					if let _error = error as? SessionGetMapper.Error {
						switch _error {
						case .failed(let explanation):
							self?.torrentsPageViewModel.alertMessage = explanation
							self?.torrentsPageViewModel.alertMessageVisible = true
						case .authenticationFailed:
							self?.torrentsPageViewModel.newValues(TorrentsPageViewModel.credentialRequired())
						case .missingSessionId(let sessionId):
							guard let _sessionId = sessionId as? String else {
								// TODO: Handle error
								break
							}
							self?.sessionIdHandler(_sessionId)
							self?.loadData()
						case .invalidData:
							self?.torrentsPageViewModel.newValues(TorrentsPageViewModel.error())
						case .serverTimeout:
							self?.torrentsPageViewModel.newValues(TorrentsPageViewModel.serverTimeout())
						}
					}
				}
			},
			receiveValue: { [weak self] (downloadDirFreeSpace, torrents) in
				let viewModel = TorrentsPagePresenter.map(
					title: TorrentsPagePresenter.title,
					isLoading: false,
					error: nil,
					uploadSpeed: torrents.reduce(0) { $0 + $1.rateUpload },
					downloadSpeed: torrents.reduce(0) { $0 + $1.rateDownload },
					torrents: torrents,
					freeDiskSpace: downloadDirFreeSpace,
					emptyMessage: nil,
					canAddTorrent: true,
					alertMessage: nil,
					alertMessageVisible: false
				)
				self?.torrentsPageViewModel.newValues(viewModel)
				DispatchQueue.main.asyncAfter(deadline: .now() + DispatchTimeInterval.seconds(UserDefaultsHandler.shared.pollingRate)) { [weak self] in
					if let cancellable, self?.cancellables.contains(cancellable) == true {
						self?.cancellables.remove(cancellable)
						self?.loadData()
					}
				}
			}
		)
		cancellable?.store(in: &cancellables)
	}
}

private extension TorrentsPageViewModel {
	func newValues(_ viewModel: TorrentsPageViewModel) {
		title = viewModel.title
		isLoading = viewModel.isLoading
		error = viewModel.error
		uploadSpeed = viewModel.uploadSpeed
		downloadSpeed = viewModel.downloadSpeed
		torrents = viewModel.torrents
		freeDiskSpace = viewModel.freeDiskSpace
		emptyMessage = viewModel.emptyMessage
	}
}
