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
		XCTAssertEqual(SettingsPresenter.title, localized("SETTINGS_PAGE_TITLE", table: table))
	}

	func test_seconds_isLocalized() {
		XCTAssertEqual(SettingsPresenter.seconds, localized("SECONDS", table: table))
	}
	
	func test_pollingRateTitle_isLocalized() {
		XCTAssertEqual(SettingsPresenter.pollingRateTitle, localized("POLLING_RATE_TITLE", table: table))
	}

	func test_serverTitle_isLocalized() {
		XCTAssertEqual(SettingsPresenter.serverTitle, localized("SERVER_TITLE", table: table))
	}
	
	func test_serverNotAvailable_isLocalized() {
		XCTAssertEqual(SettingsPresenter.serverNotAvailable, localized("SERVER_NOT_AVAILABLE", table: table))
	}
	
	func test_map_createsViewModel() {
		let title = "Settings"
		let pollingRateTitle = "Update interval"
		let pollingRateList = [2, 5, 10, 30]
		let currentSelectedPollingRate = 1
		let serversTitle = "Server"
		let currentServerName = "A server"
		
		let viewModel = SettingsPresenter.map(
			title: title,
			pollingRateTitle: pollingRateTitle,
			pollingRateList: pollingRateList,
			currentSelectedPollingRate: currentSelectedPollingRate,
			serversTitle: serversTitle,
			currentServerName: currentServerName
		)
		
		XCTAssertEqual(viewModel.title, title)
		XCTAssertEqual(viewModel.pollingRateTitle, pollingRateTitle)
		XCTAssertEqual(viewModel.pollingRateList, pollingRateList.map { "\($0) \(SettingsPresenter.seconds)" })
		XCTAssertEqual(viewModel.currentSelectedPollingRate, "\(pollingRateList[currentSelectedPollingRate]) \(SettingsPresenter.seconds)")
		XCTAssertEqual(viewModel.serversTitle, serversTitle)
		XCTAssertEqual(viewModel.currentServerName, currentServerName)
	}
	
}
