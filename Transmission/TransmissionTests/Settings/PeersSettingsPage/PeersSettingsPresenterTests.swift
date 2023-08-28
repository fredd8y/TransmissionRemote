//
//  PeersSettingsPresenterTests.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 28/08/23.
//

import XCTest
import Transmission

final class PeersSettingsPresenterTests: XCTestCase {
	
	private let table = "PeersSettings"
	
	func test_title_isLocalized() {
		XCTAssertEqual(PeersSettingsPagePresenter.title, localized("PEERS_SETTINGS_PAGE_TITLE", table: table))
	}
	
}
