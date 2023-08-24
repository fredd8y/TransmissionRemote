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
	
	func test_settingsPageWithAllToggleOff() {
		let sut = makeSUTWithAllToggleOff()
		
		assert(snapshot: sut.snapshot(.iPhone13(style: .light)), named: "TORRENTS_SETTINGS_PAGE_ALL_TOGGLE_OFF_light")
		assert(snapshot: sut.snapshot(.iPhone13(style: .dark)), named: "TORRENTS_SETTINGS_PAGE_ALL_TOGGLE_OFF_dark")
		assert(snapshot: sut.snapshot(.iPhone13(style: .light, contentSize: .extraExtraExtraLarge)), named: "TORRENTS_SETTINGS_PAGE_ALL_TOGGLE_OFF_light_extraExtraExtraLarge")
	}
	
	func test_settingsPageWithTextFieldErrors() {
		let sut = makeSUTWithTextFieldErrors()
		
		assert(snapshot: sut.snapshot(.iPhone13(style: .light)), named: "TORRENTS_SETTINGS_PAGE_TEXT_FIELD_ERRORS_light")
		assert(snapshot: sut.snapshot(.iPhone13(style: .dark)), named: "TORRENTS_SETTINGS_PAGE_TEXT_FIELD_ERRORS_dark")
		assert(snapshot: sut.snapshot(.iPhone13(style: .light, contentSize: .extraExtraExtraLarge)), named: "TORRENTS_SETTINGS_PAGE_TEXT_FIELD_ERRORS_light_extraExtraExtraLarge")
	}
	
	func test_settingsPageLoading() {
		let sut = makeSUTLoading()
		
		assert(snapshot: sut.snapshot(.iPhone13(style: .light)), named: "TORRENTS_SETTINGS_PAGE_LOADING_light")
		assert(snapshot: sut.snapshot(.iPhone13(style: .dark)), named: "TORRENTS_SETTINGS_PAGE_LOADING_dark")
		assert(snapshot: sut.snapshot(.iPhone13(style: .light, contentSize: .extraExtraExtraLarge)), named: "TORRENTS_SETTINGS_PAGE_LOADING_light_extraExtraExtraLarge")
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
	
	private func makeSUTWithAllToggleOff() -> TorrentsSettingsPage {
		TorrentsSettingsPage(viewModel: TorrentsSettingsPageViewModel(
			downloadDir: "a download dir",
			startAddedTorrents: false,
			renamePartialFiles: false,
			seedRatioLimited: false,
			seedRatioLimit: "3",
			idleSeedingLimitEnabled: false,
			idleSeedingLimit: "30",
			errorMessage: nil,
			isLoading: false,
			seedRatioLimitError: false,
			idleSeedingLimitError: false
		))
	}
	
	private func makeSUTWithTextFieldErrors() -> TorrentsSettingsPage {
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
			seedRatioLimitError: true,
			idleSeedingLimitError: true
		))
	}
	
	private func makeSUTLoading() -> TorrentsSettingsPage {
		TorrentsSettingsPage(viewModel: TorrentsSettingsPageViewModel(
			downloadDir: "a download dir",
			startAddedTorrents: true,
			renamePartialFiles: true,
			seedRatioLimited: true,
			seedRatioLimit: "3",
			idleSeedingLimitEnabled: true,
			idleSeedingLimit: "30",
			errorMessage: nil,
			isLoading: true,
			seedRatioLimitError: true,
			idleSeedingLimitError: true
		))
	}
}
