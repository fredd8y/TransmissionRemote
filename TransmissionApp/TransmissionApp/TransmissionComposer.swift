//
//  TransmissionComposer.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 24/07/23.
//

import Combine
import SwiftUI
import Transmission
import TransmissioniOS


final class TransmissionComposer {
	private init() {}
	
	private static var cancellable: Cancellable?
	
	public static func torrentsPagePresentationAdapter(
		sessionLoader: @escaping () -> AnyPublisher<Session, Error>,
		torrentLoader: @escaping () -> AnyPublisher<[Torrent], Error>
	) -> TorrentsPage {
		let viewModel = TorrentsViewModel.empty()
		
		var torrentsPage = TorrentsPage(viewModel: viewModel)
		
		let torrentsPagePresentationAdapter = TorrentsPagePresentationAdapter(
			torrentsPage: torrentsPage,
			torrentsPageViewModel: viewModel,
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
}
