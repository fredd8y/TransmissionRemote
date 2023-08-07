//
//  TorrentsPagePresentationAdapter.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 24/07/23.
//

import Combine
import Transmission
import TransmissioniOS

final class TorrentsPagePresentationAdapter {
	
	private let torrentsPage: TorrentsPage
	
	private let sessionLoader: () -> AnyPublisher<Session, Error>
	private let torrentLoader: () -> AnyPublisher<[Torrent], Error>
	private var cancellable: Cancellable?
	private var sessionIdHandler: (String) -> Void
	
	init(
		torrentsPage: TorrentsPage,
		sessionLoader: @escaping () -> AnyPublisher<Session, Error>,
		torrentLoader: @escaping () -> AnyPublisher<[Torrent], Error>,
		sessionIdHandler: @escaping (String) -> Void
	) {
		self.torrentsPage = torrentsPage
		self.sessionLoader = sessionLoader
		self.torrentLoader = torrentLoader
		self.sessionIdHandler = sessionIdHandler
	}
	
	func loadData() {
		cancellable = Publishers.Zip(sessionLoader(), torrentLoader())
			.dispatchOnMainQueue()
			.sink(
				receiveCompletion: { [weak self] completion in
					switch completion {
					case .finished:
						break
					case let .failure(error):
						guard let _error = error as? SessionGetMapper.Error else {
							return
						}
						switch _error {
						case .authenticationFailed:
							self?.torrentsPage.askForCredentials()
						case .missingSessionId(let sessionId):
							guard let _sessionId = sessionId as? String else {
								//TODO: Handle error
								break
							}
							self?.sessionIdHandler(_sessionId)
							self?.loadData()
						default:
							break
						}
					}
				},
				receiveValue: { [weak self] (session, torrents) in
					let viewModel = TorrentsPresenter.map(
						title: TorrentsPresenter.title,
						error: nil,
						uploadSpeed: torrents.reduce(0, { $0 + $1.rateUpload }),
						downloadSpeed: torrents.reduce(0, { $0 + $1.rateDownload }),
						torrents: torrents)
					self?.torrentsPage.update(withViewModel: viewModel)
				}
			)
			
	}
	
}
