//
//  TransmissionUIComposer.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 24/07/23.
//

import Combine
import Transmission
import TransmissioniOS


final class TransmissionUIComposer {
	private init() {}
	
	public static func torrentsPagePresentationAdapter(
		sessionLoader: @escaping () -> AnyPublisher<Session, Error>,
		torrentLoader: @escaping () -> AnyPublisher<[Torrent], Error>
	) -> TorrentsPage {
		var torrentsPage = makeTorrentsPage()
		
		let torrentsPagePresentationAdapter = TorrentsPagePresentationAdapter(
			torrentsPage: torrentsPage,
			sessionLoader: sessionLoader,
			torrentLoader: torrentLoader
		)
		
		torrentsPage.loadData = torrentsPagePresentationAdapter.loadData
		
		return torrentsPage
	}
	
	private static func makeTorrentsPage() -> TorrentsPage {
		TorrentsPage(model: .empty)
	}
}
