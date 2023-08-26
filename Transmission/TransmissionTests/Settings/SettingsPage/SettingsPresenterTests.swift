//
//  SettingsPresenterTests.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 27/07/23.
//

import XCTest
import Transmission

final class SettingsPresenterTests: XCTestCase {

	private let table = "Settings"
	
	func test_title_isLocalized() {
		XCTAssertEqual(SettingsPagePresenter.title, localized("SETTINGS_PAGE_TITLE", table: table))
	}

	func test_seconds_isLocalized() {
		XCTAssertEqual(SettingsPagePresenter.seconds, localized("SECONDS", table: table))
	}
	
	func test_pollingRateTitle_isLocalized() {
		XCTAssertEqual(SettingsPagePresenter.pollingRateTitle, localized("POLLING_RATE_TITLE", table: table))
	}

	func test_serverTitle_isLocalized() {
		XCTAssertEqual(SettingsPagePresenter.serverTitle, localized("SERVER_TITLE", table: table))
	}
	
	func test_serverNotAvailable_isLocalized() {
		XCTAssertEqual(SettingsPagePresenter.serverNotAvailable, localized("SERVER_NOT_AVAILABLE", table: table))
	}
	
	func test_credits_isLocalized() {
		XCTAssertEqual(SettingsPagePresenter.credits, localized("CREDITS", table: table))
	}
	
	func test_torrentsSettings_isLocalized() {
		XCTAssertEqual(SettingsPagePresenter.torrentsSettings, localized("TORRENTS_SETTINGS", table: table))
	}
	
	func test_speedSettings_isLocalized() {
		XCTAssertEqual(SettingsPagePresenter.speedSettings, localized("SPEED_SETTINGS", table: table))
	}
	
	func test_map_createsViewModel() {
		let title = "Settings"
		let pollingRateTitle = "Update interval"
		let pollingRateList = [2, 5, 10, 30]
		let currentSelectedPollingRate = 1
		let serversTitle = "Server"
		let currentServerName = "A server"
		
		let viewModel = SettingsPagePresenter.map(
			title: title,
			pollingRateTitle: pollingRateTitle,
			pollingRateList: pollingRateList,
			currentSelectedPollingRate: currentSelectedPollingRate,
			serversTitle: serversTitle,
			currentServerName: currentServerName
		)
		
		XCTAssertEqual(viewModel.title, title)
		XCTAssertEqual(viewModel.pollingRateTitle, pollingRateTitle)
		XCTAssertEqual(viewModel.pollingRateList, pollingRateList.map { "\($0) \(SettingsPagePresenter.seconds)" })
		XCTAssertEqual(viewModel.currentSelectedPollingRate, "\(pollingRateList[currentSelectedPollingRate]) \(SettingsPagePresenter.seconds)")
		XCTAssertEqual(viewModel.serversTitle, serversTitle)
		XCTAssertEqual(viewModel.currentServerName, currentServerName)
	}
	
}
