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
	
	init(
		torrentsPage: TorrentsPage,
		sessionLoader: @escaping () -> AnyPublisher<Session, Error>,
		torrentLoader: @escaping () -> AnyPublisher<[Torrent], Error>
	) {
		self.torrentsPage = torrentsPage
		self.sessionLoader = sessionLoader
		self.torrentLoader = torrentLoader
	}
	
	func loadData() {
		cancellable = Publishers.Zip(sessionLoader(), torrentLoader())
			.dispatchOnMainQueue()
			.sink(
				receiveCompletion: { completion in
					switch completion {
					case .finished:
						break
					case let .failure(error):
						// TODO: handle error on presenter
						break
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
