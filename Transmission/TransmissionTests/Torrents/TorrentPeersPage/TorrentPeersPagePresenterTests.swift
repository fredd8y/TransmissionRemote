//
//  TorrentPeersPagePresenterTests.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 20/08/23.
//

import XCTest
@testable import Transmission

final class TorrentPeersPagePresenterTests: XCTorrentTestCase {
	
	private let table = "TorrentPeers"
	
	func test_title_isLocalized() {
		XCTAssertEqual(TorrentPeersPagePresenter.title, localized("TITLE", table: table))
	}
	
}
