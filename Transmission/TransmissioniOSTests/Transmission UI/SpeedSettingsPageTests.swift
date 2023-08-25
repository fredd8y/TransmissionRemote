//
//  SpeedSettingsPageTests.swift
//  TransmissioniOSTests
//
//  Created by Federico Arvat on 25/08/23.
//

import Foundation

import XCTest
@testable import Transmission
@testable import TransmissioniOS

class SpeedSettingsPageTests: XCTestCase {
	func test_settingsPageWithAllToggleOn() {
		let sut = makeSUTWithAllToggleOn()
		
		assert(snapshot: sut.snapshot(.iPhone13(style: .light)), named: "SPEED_SETTINGS_PAGE_ALL_TOGGLE_ON_light")
		assert(snapshot: sut.snapshot(.iPhone13(style: .dark)), named: "SPEED_SETTINGS_PAGE_ALL_TOGGLE_ON_dark")
		assert(snapshot: sut.snapshot(.iPhone13(style: .light, contentSize: .extraExtraExtraLarge)), named: "SPEED_SETTINGS_PAGE_ALL_TOGGLE_ON_light_extraExtraExtraLarge")
	}
	
	// MARK: - Helpers
	
	private func makeSUTWithAllToggleOn() -> SpeedSettingsPage {
		SpeedSettingsPage(viewModel: SpeedSettingsPageViewModel(
			isLoading: false,
			errorMessage: nil,
			uploadLimitEnabled: true,
			uploadLimit: "100",
			uploadLimitError: false,
			downloadLimitEnabled: true,
			downloadLimit: "100",
			downloadLimitError: false,
			alternativeUploadLimit: "100",
			alternativeUploadLimitError: false,
			alternativeDownloadLimit: "100",
			alternativeDownloadLimitError: false,
			scheduledTimesEnabled: true,
			alternativeSpeedTimeBegin: .hour0000,
			alternativeSpeedTimeDay: .everyday,
			alternativeSpeedTimeEnd: .hour0000
		))
	}
}
