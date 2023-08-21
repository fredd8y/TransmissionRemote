//
//  TorrentTrackersPagePresenterTests.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 21/08/23.
//

import XCTest
@testable import Transmission

final class TorrentTrackersPagePresenterTests: XCTorrentTestCase {
	
	private let table = "TorrentTrackers"
	
	func test_title_isLocalized() {
		XCTAssertEqual(TorrentTrackersPagePresenter.title, localized("TITLE", table: table))
	}
	
}
