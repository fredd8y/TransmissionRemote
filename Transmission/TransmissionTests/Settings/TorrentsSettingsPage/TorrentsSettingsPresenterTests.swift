//
//  TorrentsSettingsPresenterTests.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 22/08/23.
//

import XCTest
import Transmission

final class TorrentsSettingsPresenterTests: XCTestCase {
	
	private let table = "TorrentsSettings"
	
	func test_title_isLocalized() {
		XCTAssertEqual(TorrentsSettingsPagePresenter.title, localized("TORRENTS_SETTINGS_PAGE_TITLE", table: table))
	}
}
