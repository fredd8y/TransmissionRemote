//
//  TorrentsSettingsPageTests.swift
//  TransmissioniOSTests
//
//  Created by Federico Arvat on 23/08/23.
//

import XCTest
@testable import Transmission
@testable import TransmissioniOS

class TorrentsSettingsPageTests: XCTestCase {
	func test_settingsPageWithAllToggleOn() {
		let sut = makeSUTWithAllToggleOn()
		
		assert(snapshot: sut.snapshot(.iPhone13(style: .light)), named: "TORRENTS_SETTINGS_PAGE_ALL_TOGGLE_ON_light")
		assert(snapshot: sut.snapshot(.iPhone13(style: .dark)), named: "TORRENTS_SETTINGS_PAGE_ALL_TOGGLE_ON_dark")
		assert(snapshot: sut.snapshot(.iPhone13(style: .light, contentSize: .extraExtraExtraLarge)), named: "TORRENTS_SETTINGS_PAGE_ALL_TOGGLE_ON_light_extraExtraExtraLarge")
	}
	
	// MARK: - Helpers
	
	private func makeSUTWithAllToggleOn() -> TorrentsSettingsPage {
		TorrentsSettingsPage(viewModel: TorrentsSettingsPageViewModel(
			downloadDir: "a download dir",
			startAddedTorrents: true,
			renamePartialFiles: true,
			seedRatioLimited: true,
			seedRatioLimit: "3",
			idleSeedingLimitEnabled: true,
			idleSeedingLimit: "30",
			errorMessage: nil,
			isLoading: false,
			seedRatioLimitError: false,
			idleSeedingLimitError: false
		))
	}
}
