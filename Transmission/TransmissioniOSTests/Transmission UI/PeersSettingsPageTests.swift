//
//  PeersSettingsPageTests.swift
//  TransmissioniOSTests
//
//  Created by Federico Arvat on 29/08/23.
//

import Foundation
import XCTest
@testable import Transmission
@testable import TransmissioniOS

class PeersSettingsPageTests: XCTestCase {
	
	func test_settingsPageWithAllToggleOn() {
		let sut = makeSUTWithAllToggleOn()
		
		assert(snapshot: sut.snapshot(.iPhone13(style: .light)), named: "PEERS_SETTINGS_PAGE_ALL_TOGGLE_ON_light")
		assert(snapshot: sut.snapshot(.iPhone13(style: .dark)), named: "PEERS_SETTINGS_PAGE_ALL_TOGGLE_ON_dark")
		assert(snapshot: sut.snapshot(.iPhone13(style: .light, contentSize: .extraExtraExtraLarge)), named: "PEERS_SETTINGS_PAGE_ALL_TOGGLE_ON_light_extraExtraExtraLarge")
	}
	
	func test_settingsPageWithAllToggleOff() {
		let sut = makeSUTWithAllToggleOff()
		
		assert(snapshot: sut.snapshot(.iPhone13(style: .light)), named: "PEERS_SETTINGS_PAGE_ALL_TOGGLE_OFF_light")
		assert(snapshot: sut.snapshot(.iPhone13(style: .dark)), named: "PEERS_SETTINGS_PAGE_ALL_TOGGLE_OFF_dark")
		assert(snapshot: sut.snapshot(.iPhone13(style: .light, contentSize: .extraExtraExtraLarge)), named: "PEERS_SETTINGS_PAGE_ALL_TOGGLE_OFF_light_extraExtraExtraLarge")
	}
	
	func test_settingsPageWithAllTextFieldErrorShown() {
		let sut = makeSUTWithAllTextFieldErrorShown()
		
		assert(snapshot: sut.snapshot(.iPhone13(style: .light)), named: "PEERS_SETTINGS_PAGE_ALL_TEXTFIELD_ERROR_SHOW_light")
		assert(snapshot: sut.snapshot(.iPhone13(style: .dark)), named: "PEERS_SETTINGS_PAGE_ALL_TEXTFIELD_ERROR_SHOW_dark")
		assert(snapshot: sut.snapshot(.iPhone13(style: .light, contentSize: .extraExtraExtraLarge)), named: "PEERS_SETTINGS_PAGE_ALL_TEXTFIELD_ERROR_SHOW_light_extraExtraExtraLarge")
	}
	
	func test_settingsPageLoading() {
		let sut = makeSUTLoading()
		
		assert(snapshot: sut.snapshot(.iPhone13(style: .light)), named: "PEERS_SETTINGS_PAGE_LOADING_light")
		assert(snapshot: sut.snapshot(.iPhone13(style: .dark)), named: "PEERS_SETTINGS_PAGE_LOADING_dark")
		assert(snapshot: sut.snapshot(.iPhone13(style: .light, contentSize: .extraExtraExtraLarge)), named: "PEERS_SETTINGS_PAGE_LOADING_light_extraExtraExtraLarge")
	}
	
	func test_settingsPageAlertMessage() {
		let sut = makeSUTWithAlertMessageShown()

		assert(snapshot: sut.snapshot(.iPhone13(style: .light)), named: "PEERS_SETTINGS_PAGE_ALERT_MESSAGE_light")
		assert(snapshot: sut.snapshot(.iPhone13(style: .dark)), named: "PEERS_SETTINGS_PAGE_ALERT_MESSAGE_dark")
		assert(snapshot: sut.snapshot(.iPhone13(style: .light, contentSize: .extraExtraExtraLarge)), named: "PEERS_SETTINGS_PAGE_ALERT_MESSAGE_light_extraExtraExtraLarge")
	}
	
	func test_settingsPageWithError() {
		let sut = makeSUTWithErrorShown()

		assert(snapshot: sut.snapshot(.iPhone13(style: .light)), named: "PEERS_SETTINGS_PAGE_ERROR_light")
		assert(snapshot: sut.snapshot(.iPhone13(style: .dark)), named: "PEERS_SETTINGS_PAGE_ERROR_dark")
		assert(snapshot: sut.snapshot(.iPhone13(style: .light, contentSize: .extraExtraExtraLarge)), named: "PEERS_SETTINGS_PAGE_ERROR_light_extraExtraExtraLarge")
	}
	
	func test_settingsPageWithUpdatingBlockListLoader() {
		let sut = makeSUTWithUpdatingBlockListLoading()

		assert(snapshot: sut.snapshot(.iPhone13(style: .light)), named: "PEERS_SETTINGS_PAGE_UPDATING_BLOCK_LIST_LOADING_light")
		assert(snapshot: sut.snapshot(.iPhone13(style: .dark)), named: "PEERS_SETTINGS_PAGE_UPDATING_BLOCK_LIST_LOADING_dark")
		assert(snapshot: sut.snapshot(.iPhone13(style: .light, contentSize: .extraExtraExtraLarge)), named: "PEERS_SETTINGS_PAGE_UPDATING_BLOCK_LIST_LOADING_light_extraExtraExtraLarge")
	}
	
	// MARK: - Helpers
	
	private func makeSUTLoading() -> PeersSettingsPage {
		PeersSettingsPage(viewModel: PeersSettingsPageViewModel(
			isUpdatingBlocklist: false,
			alertMessage: nil,
			alertMessageVisible: false,
			errorMessage: nil,
			isLoading: true,
			peerLimitGlobal: "-",
			peerLimitGlobalError: false,
			peerLimitPerTorrent: "-",
			peerLimitPerTorrentError: false,
			pexEnabled: false,
			dhtEnabled: false,
			lpdEnabled: false,
			blocklistEnabled: false,
			blocklistSize: "-",
			blocklistUrl: "-",
			blocklistUrlError: false,
			encryption: .tolerated
		))
	}
	
	private func makeSUTWithAllTextFieldErrorShown() -> PeersSettingsPage {
		PeersSettingsPage(viewModel: PeersSettingsPageViewModel(
			isUpdatingBlocklist: false,
			alertMessage: nil,
			alertMessageVisible: false,
			errorMessage: nil,
			isLoading: false,
			peerLimitGlobal: "-",
			peerLimitGlobalError: true,
			peerLimitPerTorrent: "-",
			peerLimitPerTorrentError: true,
			pexEnabled: false,
			dhtEnabled: false,
			lpdEnabled: false,
			blocklistEnabled: false,
			blocklistSize: "-",
			blocklistUrl: "-",
			blocklistUrlError: true,
			encryption: .tolerated
		))
	}
	
	private func makeSUTWithAllToggleOn() -> PeersSettingsPage {
		PeersSettingsPage(viewModel: PeersSettingsPageViewModel(
			isUpdatingBlocklist: false,
			alertMessage: nil,
			alertMessageVisible: false,
			errorMessage: nil,
			isLoading: false,
			peerLimitGlobal: "-",
			peerLimitGlobalError: false,
			peerLimitPerTorrent: "-",
			peerLimitPerTorrentError: false,
			pexEnabled: true,
			dhtEnabled: true,
			lpdEnabled: true,
			blocklistEnabled: true,
			blocklistSize: "-",
			blocklistUrl: "-",
			blocklistUrlError: false,
			encryption: .tolerated
		))
	}
	
	private func makeSUTWithAllToggleOff() -> PeersSettingsPage {
		PeersSettingsPage(viewModel: PeersSettingsPageViewModel(
			isUpdatingBlocklist: false,
			alertMessage: nil,
			alertMessageVisible: false,
			errorMessage: nil,
			isLoading: false,
			peerLimitGlobal: "-",
			peerLimitGlobalError: false,
			peerLimitPerTorrent: "-",
			peerLimitPerTorrentError: false,
			pexEnabled: false,
			dhtEnabled: false,
			lpdEnabled: false,
			blocklistEnabled: false,
			blocklistSize: "-",
			blocklistUrl: "-",
			blocklistUrlError: false,
			encryption: .tolerated
		))
	}

	private func makeSUTWithAlertMessageShown() -> PeersSettingsPage {
		PeersSettingsPage(viewModel: PeersSettingsPageViewModel(
			isUpdatingBlocklist: false,
			alertMessage: "Alert message",
			alertMessageVisible: true,
			errorMessage: nil,
			isLoading: false,
			peerLimitGlobal: "-",
			peerLimitGlobalError: false,
			peerLimitPerTorrent: "-",
			peerLimitPerTorrentError: false,
			pexEnabled: false,
			dhtEnabled: false,
			lpdEnabled: false,
			blocklistEnabled: false,
			blocklistSize: "-",
			blocklistUrl: "-",
			blocklistUrlError: false,
			encryption: .tolerated
		))
	}
	
	private func makeSUTWithErrorShown() -> PeersSettingsPage {
		PeersSettingsPage(viewModel: PeersSettingsPageViewModel(
			isUpdatingBlocklist: false,
			alertMessage: nil,
			alertMessageVisible: false,
			errorMessage: "Error message",
			isLoading: false,
			peerLimitGlobal: "-",
			peerLimitGlobalError: false,
			peerLimitPerTorrent: "-",
			peerLimitPerTorrentError: false,
			pexEnabled: false,
			dhtEnabled: false,
			lpdEnabled: false,
			blocklistEnabled: false,
			blocklistSize: "-",
			blocklistUrl: "-",
			blocklistUrlError: false,
			encryption: .tolerated
		))
	}
	
	private func makeSUTWithUpdatingBlockListLoading() -> PeersSettingsPage {
		PeersSettingsPage(viewModel: PeersSettingsPageViewModel(
			isUpdatingBlocklist: true,
			alertMessage: nil,
			alertMessageVisible: false,
			errorMessage: nil,
			isLoading: false,
			peerLimitGlobal: "-",
			peerLimitGlobalError: false,
			peerLimitPerTorrent: "-",
			peerLimitPerTorrentError: false,
			pexEnabled: false,
			dhtEnabled: false,
			lpdEnabled: false,
			blocklistEnabled: false,
			blocklistSize: "-",
			blocklistUrl: "-",
			blocklistUrlError: false,
			encryption: .tolerated
		))
	}
	
}
