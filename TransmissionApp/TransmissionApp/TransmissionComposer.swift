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
	
	public static func containerView() -> TabContainer {
		let torrentsPage = torrentsPage()
		let serverPage = serverPage()
		let settingsPage = settingsPage(serverPage: serverPage)
		
		return TabContainer(torrentsPage: torrentsPage, settingsPage: settingsPage)
	}
	
	private static func torrentsPage() -> TorrentsPage {
		let viewModel = TorrentsPageViewModel.loading()
		
		let torrentsPagePresentationAdapter = TorrentsPagePresentationAdapter(
			torrentsPageViewModel: viewModel,
			sessionIdHandler: { sessionId in
				TransmissionHTTPClient.sessionId = sessionId
			}
		)
		
		var torrentsPage = TorrentsPage(viewModel: viewModel)
		
		torrentsPage.stop = torrentsPagePresentationAdapter.stop
		torrentsPage.start = torrentsPagePresentationAdapter.start
		torrentsPage.delete = torrentsPagePresentationAdapter.delete
		torrentsPage.stopAll = torrentsPagePresentationAdapter.stopAll
		torrentsPage.loadData = torrentsPagePresentationAdapter.loadData
		torrentsPage.startAll = torrentsPagePresentationAdapter.startAll
		torrentsPage.deleteAll = torrentsPagePresentationAdapter.deleteAll
		torrentsPage.selectedFile = torrentsPagePresentationAdapter.selectedFile
		torrentsPage.selectedLink = torrentsPagePresentationAdapter.selectedLink
		torrentsPage.setDownloadLimit = torrentsPagePresentationAdapter.setDownloadLimit
		
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
		
		serverPage.selectServer = serverPagePresentationAdapter.selectServer
		serverPage.loadData = serverPagePresentationAdapter.loadData
		serverPage.deleteServer = serverPagePresentationAdapter.delete
		
		serverPage.showServerDetail = serverDetailPresentationAdapter.showServerDetail
		serverPage.newServer = serverDetailPresentationAdapter.newServer
		
		return serverPage
	}
	
}
