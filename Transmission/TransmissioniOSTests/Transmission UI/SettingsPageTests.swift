//
//  SettingsPageTests.swift
//  TransmissioniOSTests
//
//  Created by Federico Arvat on 27/07/23.
//

import XCTest
@testable import Transmission
@testable import TransmissioniOS

class SettingsPageTests: XCTestCase {
	func test_settingsPage() {
		let sut = makeSUT()
		
		assert(snapshot: sut.snapshot(.iPhone13(style: .light)), named: "SETTINGS_PAGE_light")
		assert(snapshot: sut.snapshot(.iPhone13(style: .dark)), named: "SETTINGS_PAGE_dark")
		assert(snapshot: sut.snapshot(.iPhone13(style: .light, contentSize: .extraExtraExtraLarge)), named: "SETTINGS_PAGE_light_extraExtraExtraLarge")
	}
	
	// MARK: - Helpers
	
	private func makeSUT() -> SettingsPage {
		SettingsPage(
			viewModel: viewModel,
			serverPage: ServerPage(
				viewModel: ServerPageViewModel(
					title: ServerPagePresenter.title,
					servers: [],
					editItemActionTitle: "Edit",
					deleteItemActionTitle: "Delete",
					currentSelectedServerId: nil
				)
			)
		)
	}
	
	private var viewModel: SettingsPageViewModel {
		SettingsPageViewModel(
			title: "Settings",
			pollingRateTitle: "Update interval",
			pollingRateList: ["2 seconds", "5 seconds", "10 seconds", "30 seconds"],
			currentSelectedPollingRate: "2 seconds",
			serversTitle: "Server",
			currentServerName: "Raspberry"
		)
	}
}
