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
	}
	
	// MARK: - Helpers
	
	private func makeSUT() -> SettingsPage {
		SettingsPage(viewModel: viewModel)
	}
	
	private var viewModel: SettingsViewModel {
		SettingsViewModel(
			title: "Settings",
			updateIntervalTitle: "Update interval",
			updateIntervalList: ["2 seconds", "5 seconds", "10 seconds", "30 seconds"],
			currentSelectedIntervalIndex: 0,
			serversTitle: "Server",
			currentServerName: "Raspberry"
		)
	}
}
