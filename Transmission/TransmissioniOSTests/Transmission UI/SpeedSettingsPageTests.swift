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
	
	func test_settingsPageWithAllToggleOff() {
		let sut = makeSUTWithAllToggleOff()
		
		assert(snapshot: sut.snapshot(.iPhone13(style: .light)), named: "SPEED_SETTINGS_PAGE_ALL_TOGGLE_OFF_light")
		assert(snapshot: sut.snapshot(.iPhone13(style: .dark)), named: "SPEED_SETTINGS_PAGE_ALL_TOGGLE_OFF_dark")
		assert(snapshot: sut.snapshot(.iPhone13(style: .light, contentSize: .extraExtraExtraLarge)), named: "SPEED_SETTINGS_PAGE_ALL_TOGGLE_OFF_light_extraExtraExtraLarge")
	}
	
	func test_settingsPageWithAllTextFieldErrorShown() {
		let sut = makeSUTWithAllTextFieldErrorShown()
		
		assert(snapshot: sut.snapshot(.iPhone13(style: .light)), named: "SPEED_SETTINGS_PAGE_ALL_TEXTFIELD_ERROR_SHOW_light")
		assert(snapshot: sut.snapshot(.iPhone13(style: .dark)), named: "SPEED_SETTINGS_PAGE_ALL_TEXTFIELD_ERROR_SHOW_dark")
		assert(snapshot: sut.snapshot(.iPhone13(style: .light, contentSize: .extraExtraExtraLarge)), named: "SPEED_SETTINGS_PAGE_ALL_TEXTFIELD_ERROR_SHOW_light_extraExtraExtraLarge")
	}
	
	func test_settingsPageLoading() {
		let sut = makeSUTLoading()
		
		assert(snapshot: sut.snapshot(.iPhone13(style: .light)), named: "SPEED_SETTINGS_PAGE_LOADING_light")
		assert(snapshot: sut.snapshot(.iPhone13(style: .dark)), named: "SPEED_SETTINGS_PAGE_LOADING_dark")
		assert(snapshot: sut.snapshot(.iPhone13(style: .light, contentSize: .extraExtraExtraLarge)), named: "SPEED_SETTINGS_PAGE_LOADING_light_extraExtraExtraLarge")
	}
	
	// MARK: - Helpers
	
	private func makeSUTLoading() -> SpeedSettingsPage {
		SpeedSettingsPage(viewModel: SpeedSettingsPageViewModel(
			isLoading: true,
			errorMessage: nil,
			uploadLimitEnabled: false,
			uploadLimit: "error",
			uploadLimitError: true,
			downloadLimitEnabled: false,
			downloadLimit: "error",
			downloadLimitError: true,
			alternativeUploadLimit: "error",
			alternativeUploadLimitError: true,
			alternativeDownloadLimit: "error",
			alternativeDownloadLimitError: true,
			scheduledTimesEnabled: false,
			alternativeSpeedTimeBegin: .hour0000,
			alternativeSpeedTimeDay: .sunday,
			alternativeSpeedTimeEnd: .hour0000
		))
	}
	
	private func makeSUTWithAllTextFieldErrorShown() -> SpeedSettingsPage {
		SpeedSettingsPage(viewModel: SpeedSettingsPageViewModel(
			isLoading: false,
			errorMessage: nil,
			uploadLimitEnabled: false,
			uploadLimit: "error",
			uploadLimitError: true,
			downloadLimitEnabled: false,
			downloadLimit: "error",
			downloadLimitError: true,
			alternativeUploadLimit: "error",
			alternativeUploadLimitError: true,
			alternativeDownloadLimit: "error",
			alternativeDownloadLimitError: true,
			scheduledTimesEnabled: false,
			alternativeSpeedTimeBegin: .hour0000,
			alternativeSpeedTimeDay: .sunday,
			alternativeSpeedTimeEnd: .hour0000
		))
	}
	
	private func makeSUTWithAllToggleOff() -> SpeedSettingsPage {
		SpeedSettingsPage(viewModel: SpeedSettingsPageViewModel(
			isLoading: false,
			errorMessage: nil,
			uploadLimitEnabled: false,
			uploadLimit: "100",
			uploadLimitError: false,
			downloadLimitEnabled: false,
			downloadLimit: "100",
			downloadLimitError: false,
			alternativeUploadLimit: "100",
			alternativeUploadLimitError: false,
			alternativeDownloadLimit: "100",
			alternativeDownloadLimitError: false,
			scheduledTimesEnabled: false,
			alternativeSpeedTimeBegin: .hour0000,
			alternativeSpeedTimeDay: .sunday,
			alternativeSpeedTimeEnd: .hour0000
		))
	}
	
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
