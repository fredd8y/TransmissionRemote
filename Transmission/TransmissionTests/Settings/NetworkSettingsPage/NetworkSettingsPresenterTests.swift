//
//  NetworkSettingsPresenterTests.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 29/08/23.
//

import XCTest
import Transmission

final class NetworkSettingsPresenterTests: XCTestCase {
	
	private let table = "NetworkSettings"
	
	func test_title_isLocalized() {
		XCTAssertEqual(NetworkSettingsPagePresenter.title, localized("NETWORK_SETTINGS_PAGE_TITLE", table: table))
	}
	
}
