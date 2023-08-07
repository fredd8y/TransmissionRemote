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
	
	public static func containerView() -> ContainerView {
		let torrentsPage = torrentsPage()
		let serverPage = serverPage()
		let settingsPage = settingsPage(serverPage: serverPage)
		
		return ContainerView(torrentsPage: torrentsPage, settingsPage: settingsPage)
	}
	
	private static func torrentsPage() -> TorrentsPage {
		let viewModel = TorrentsPageViewModel.empty()
		
		let torrentsPagePresentationAdapter = TorrentsPagePresentationAdapter(
			torrentsPageViewModel: viewModel,
			sessionIdHandler: { sessionId in
				TransmissionHTTPClient.sessionId = sessionId
			}
		)
		
		var torrentsPage = TorrentsPage(viewModel: viewModel)
		torrentsPage.loadData = torrentsPagePresentationAdapter.loadData
		torrentsPage.authenticate = { username, password in
//			TransmissionHTTPClient.username = username
//			TransmissionHTTPClient.password = password
		}
		
		return torrentsPage
	}
	
	private static func settingsPage(serverPage: ServerPage) -> SettingsPage {
		let viewModel = SettingsPageViewModel.empty()
		
		let settingsPagePresentationAdapter = SettingsPagePresentationAdapter(
			settingsViewModel: viewModel
		)
		
		var settingsPage = SettingsPage(viewModel: viewModel, serverPage: serverPage)
		settingsPage.loadData = settingsPagePresentationAdapter.loadData
		settingsPage.pollingRateSelected = settingsPagePresentationAdapter.selectedPollingRate
		return settingsPage
	}
	
	private static func serverPage() -> ServerPage {
		let viewModel = ServerPageViewModel.empty()
		
		let serverPagePresentationAdapter = ServerPagePresentationAdapter(
			serversViewModel: viewModel
		)
		let serverDetailPresentationAdapter = ServerDetailPagePresentationAdapter()
		
		var serverPage = ServerPage(viewModel: viewModel)
		serverPage.loadData = serverPagePresentationAdapter.loadData
		serverPage.selectedServer = serverDetailPresentationAdapter.selectedServer
		serverPage.newServer = serverDetailPresentationAdapter.newServer
		return serverPage
	}
	
}
