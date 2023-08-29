//
//  NetworkSettingsPageTests.swift
//  TransmissioniOSTests
//
//  Created by Federico Arvat on 29/08/23.
//

import Foundation
import XCTest
@testable import Transmission
@testable import TransmissioniOS

class NetworkSettingsPageTests: XCTestCase {
	
	func test_settingsPageWithAllToggleOn() {
		let sut = makeSUTWithAllToggleOn()
		
		assert(snapshot: sut.snapshot(.iPhone13(style: .light)), named: "NETWORK_SETTINGS_PAGE_ALL_TOGGLE_ON_light")
		assert(snapshot: sut.snapshot(.iPhone13(style: .dark)), named: "NETWORK_SETTINGS_PAGE_ALL_TOGGLE_ON_dark")
		assert(snapshot: sut.snapshot(.iPhone13(style: .light, contentSize: .extraExtraExtraLarge)), named: "NETWORK_SETTINGS_PAGE_ALL_TOGGLE_ON_light_extraExtraExtraLarge")
	}
	
	func test_settingsPageWithAllToggleOff() {
		let sut = makeSUTWithAllToggleOff()
		
		assert(snapshot: sut.snapshot(.iPhone13(style: .light)), named: "NETWORK_SETTINGS_PAGE_ALL_TOGGLE_OFF_light")
		assert(snapshot: sut.snapshot(.iPhone13(style: .dark)), named: "NETWORK_SETTINGS_PAGE_ALL_TOGGLE_OFF_dark")
		assert(snapshot: sut.snapshot(.iPhone13(style: .light, contentSize: .extraExtraExtraLarge)), named: "NETWORK_SETTINGS_PAGE_ALL_TOGGLE_OFF_light_extraExtraExtraLarge")
	}
	
	func test_settingsPageWithAllTextFieldErrorShown() {
		let sut = makeSUTWithAllTextFieldErrorShown()
		
		assert(snapshot: sut.snapshot(.iPhone13(style: .light)), named: "NETWORK_SETTINGS_PAGE_ALL_TEXTFIELD_ERROR_SHOW_light")
		assert(snapshot: sut.snapshot(.iPhone13(style: .dark)), named: "NETWORK_SETTINGS_PAGE_ALL_TEXTFIELD_ERROR_SHOW_dark")
		assert(snapshot: sut.snapshot(.iPhone13(style: .light, contentSize: .extraExtraExtraLarge)), named: "NETWORK_SETTINGS_PAGE_ALL_TEXTFIELD_ERROR_SHOW_light_extraExtraExtraLarge")
	}
	
	func test_settingsPageLoading() {
		let sut = makeSUTLoading()
		
		assert(snapshot: sut.snapshot(.iPhone13(style: .light)), named: "NETWORK_SETTINGS_PAGE_LOADING_light")
		assert(snapshot: sut.snapshot(.iPhone13(style: .dark)), named: "NETWORK_SETTINGS_PAGE_LOADING_dark")
		assert(snapshot: sut.snapshot(.iPhone13(style: .light, contentSize: .extraExtraExtraLarge)), named: "NETWORK_SETTINGS_PAGE_LOADING_light_extraExtraExtraLarge")
	}
	
	func test_settingsPageWithError() {
		let sut = makeSUTWithErrorShown()
		
		assert(snapshot: sut.snapshot(.iPhone13(style: .light)), named: "NETWORK_SETTINGS_PAGE_ERROR_light")
		assert(snapshot: sut.snapshot(.iPhone13(style: .dark)), named: "NETWORK_SETTINGS_PAGE_ERROR_dark")
		assert(snapshot: sut.snapshot(.iPhone13(style: .light, contentSize: .extraExtraExtraLarge)), named: "NETWORK_SETTINGS_PAGE_ERROR_light_extraExtraExtraLarge")
	}
	
	// MARK: - Helpers
	
	private func makeSUTWithAllToggleOn() -> NetworkSettingsPage {
		NetworkSettingsPage(viewModel: NetworkSettingsPageViewModel(
			errorMessage: nil,
			isLoading: false,
			peerPort: "54321",
			peerPortError: false,
			peerPortRandomOnStart: true,
			portForwardingEnabled: true,
			utpEnabled: true,
			portStatus: "Open"
		))
	}
	
	private func makeSUTWithAllToggleOff() -> NetworkSettingsPage {
		NetworkSettingsPage(viewModel: NetworkSettingsPageViewModel(
			errorMessage: nil,
			isLoading: false,
			peerPort: "54321",
			peerPortError: false,
			peerPortRandomOnStart: false,
			portForwardingEnabled: false,
			utpEnabled: false,
			portStatus: "Open"
		))
	}
	
	private func makeSUTWithAllTextFieldErrorShown() -> NetworkSettingsPage {
		NetworkSettingsPage(viewModel: NetworkSettingsPageViewModel(
			errorMessage: nil,
			isLoading: false,
			peerPort: "54321",
			peerPortError: true,
			peerPortRandomOnStart: false,
			portForwardingEnabled: false,
			utpEnabled: false,
			portStatus: "Open"
		))
	}
	
	private func makeSUTLoading() -> NetworkSettingsPage {
		NetworkSettingsPage(viewModel: NetworkSettingsPageViewModel(
			errorMessage: nil,
			isLoading: true,
			peerPort: "54321",
			peerPortError: true,
			peerPortRandomOnStart: false,
			portForwardingEnabled: false,
			utpEnabled: false,
			portStatus: "Open"
		))
	}
	
	private func makeSUTWithErrorShown() -> NetworkSettingsPage {
		NetworkSettingsPage(viewModel: NetworkSettingsPageViewModel(
			errorMessage: "Error message",
			isLoading: false,
			peerPort: "54321",
			peerPortError: true,
			peerPortRandomOnStart: false,
			portForwardingEnabled: false,
			utpEnabled: false,
			portStatus: "Open"
		))
	}
	
}
