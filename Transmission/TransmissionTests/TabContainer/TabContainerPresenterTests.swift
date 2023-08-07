//
//  TabContainerPresenterTests.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 04/08/23.
//

import XCTest
import Transmission

final class TabContainerPresenterTests: XCTorrentTestCase {
	
	private let table = "TabContainer"
	
	func test_torrent_isLocalized() {
		XCTAssertEqual(TabContainerPresenter.torrent, localized("TORRENT", table: table))
	}
	
	func test_settings_isLocalized() {
		XCTAssertEqual(TabContainerPresenter.settings, localized("SETTINGS", table: table))
	}
	
}
