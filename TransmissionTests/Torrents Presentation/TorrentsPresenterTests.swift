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
	
	func test_of_isLocalized() {
		XCTAssertEqual(TorrentsPresenter.of, localized("TORRENT_ITEM_OF_PREPOSITION"))
	}
	
	func test_eta_isLocalized() {
		XCTAssertEqual(TorrentsPresenter.eta, localized("TORRENT_ITEM_ETA"))
	}
	
	// MARK: - Helpers
	
	private func localized(_ key: String, file: StaticString = #filePath, line: UInt = #line) -> String {
		let table = "Torrents"
		let bundle = Bundle(for: TorrentsPresenter.self)
		let value = bundle.localizedString(forKey: key, value: nil, table: table)
		if value == key {
			XCTFail("Missing localized string for key: \(key) in table: \(table)", file: file, line: line)
		}
		return value
	}
	
}
