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
	
	func test_updateIntervalTitle_isLocalized() {
		XCTAssertEqual(SettingsPresenter.updateIntervalTitle, localized("UPDATE_INTERVAL_TITLE", table: table))
	}

	func test_serverTitle_isLocalized() {
		XCTAssertEqual(SettingsPresenter.serverTitle, localized("SERVER_TITLE", table: table))
	}
	
	func test_serverNotAvailable_isLocalized() {
		XCTAssertEqual(SettingsPresenter.serverNotAvailable, localized("SERVER_NOT_AVAILABLE", table: table))
	}
	
	func test_map_createsViewModel() {
		let title = "Settings"
		let updateIntervalTitle = "Update interval"
		let updateIntervalList = [2, 5, 10, 30]
		let currentSelectedIntervalIndex = 1
		let serversTitle = "Server"
		let currentServerName = "A server"
		
		let viewModel = SettingsPresenter.map(
			title: title,
			updateIntervalTitle: updateIntervalTitle,
			updateIntervalList: updateIntervalList,
			currentSelectedIntervalIndex: currentSelectedIntervalIndex,
			serversTitle: serversTitle,
			currentServerName: currentServerName
		)
		
		XCTAssertEqual(viewModel.title, title)
		XCTAssertEqual(viewModel.updateIntervalTitle, updateIntervalTitle)
		XCTAssertEqual(viewModel.updateIntervalList, updateIntervalList.map { "\($0) \(SettingsPresenter.seconds)" })
		XCTAssertEqual(viewModel.currentSelectedIntervalIndex, currentSelectedIntervalIndex)
		XCTAssertEqual(viewModel.serversTitle, serversTitle)
		XCTAssertEqual(viewModel.currentServerName, currentServerName)
	}
	
}
