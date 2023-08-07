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
		let settingsPage = settingsPage()
		
		return ContainerView(torrentsPage: torrentsPage, settingsPage: settingsPage)
	}
	
	private static func torrentsPage() -> TorrentsPage {
		let viewModel = TorrentsViewModel.empty()
		
		let torrentsPagePresentationAdapter = TorrentsPagePresentationAdapter(
			torrentsPageViewModel: viewModel,
			sessionIdHandler: { sessionId in
				TransmissionHTTPClient.sessionId = sessionId
			}
		)
		
		var torrentsPage = TorrentsPage(viewModel: viewModel)
		torrentsPage.loadData = torrentsPagePresentationAdapter.loadData
		torrentsPage.authenticate = { username, password in
			TransmissionHTTPClient.username = username
			TransmissionHTTPClient.password = password
		}
		
		return torrentsPage
	}
	
	private static func settingsPage() -> SettingsPage {
		let viewModel = SettingsViewModel.empty()
		
		let settingsPagePresentationAdapter = SettingsPagePresentationAdapter(
			settingsViewModel: viewModel
		)
		
		var settingsPage = SettingsPage(viewModel: viewModel)
		settingsPage.loadData = settingsPagePresentationAdapter.loadData
		settingsPage.updateIntervalSelected = settingsPagePresentationAdapter.selectedUpdateInterval
		// Add to settingsPage closures to update servers
		return settingsPage
	}
}
