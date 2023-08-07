//
//  TorrentsPresenterTests.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 19/07/23.
//

import XCTest
import Transmission

final class TorrentsPresenterTests: XCTestCase {
	
	func test_title_isLocalized() {
		XCTAssertEqual(TorrentsPresenter.title, localized("TORRENTS_VIEW_TITLE"))
	}
	
}
