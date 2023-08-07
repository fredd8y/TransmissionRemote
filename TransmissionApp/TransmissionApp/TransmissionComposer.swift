//
//  TransmissionComposer.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 24/07/23.
//

import Combine
import Transmission
import TransmissioniOS


final class TransmissionComposer {
	private init() {}
	
	public static func torrentsPagePresentationAdapter(
		sessionLoader: @escaping () -> AnyPublisher<Session, Error>,
		torrentLoader: @escaping () -> AnyPublisher<[Torrent], Error>
	) -> TorrentsPage {
		var torrentsPage = makeTorrentsPage()
		
		let torrentsPagePresentationAdapter = TorrentsPagePresentationAdapter(
			torrentsPage: torrentsPage,
			sessionLoader: sessionLoader,
			torrentLoader: torrentLoader,
			sessionIdHandler: { sessionId in
				TransmissionHTTPClient.sessionId = sessionId
			}
		)
		
		torrentsPage.loadData = torrentsPagePresentationAdapter.loadData
		torrentsPage.authenticate = { username, password in
			TransmissionHTTPClient.username = username
			TransmissionHTTPClient.password = password
		}
		
		return torrentsPage
	}
	
	private static func makeTorrentsPage() -> TorrentsPage {
		TorrentsPage(model: .empty)
	}
}
