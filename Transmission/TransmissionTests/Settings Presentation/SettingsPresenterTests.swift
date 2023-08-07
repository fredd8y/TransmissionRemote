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
}
