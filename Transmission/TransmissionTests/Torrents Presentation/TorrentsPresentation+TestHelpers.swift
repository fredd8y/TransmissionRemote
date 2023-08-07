//
//  TorrentsPresentation+Localized.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 19/07/23.
//

import XCTest
import Transmission

extension XCTestCase {
	func anyTorrentWithError() -> Torrent {
		Torrent(
			name: "a name",
			error: 0,
			errorString: "an error",
			eta: 123456789,
			id: 1234,
			isFinished: false,
			percentDone: 0.76,
			rateDownload: 123456,
			rateUpload: 123456,
			totalSize: 1234567
		)
	}
	
	func anyTorrentWithoutError() -> Torrent {
		Torrent(
			name: "a name",
			error: 0,
			errorString: "",
			eta: 123456789,
			id: 1234,
			isFinished: false,
			percentDone: 0.76,
			rateDownload: 123456,
			rateUpload: 123456,
			totalSize: 1234567
		)
	}
	
	func localized(_ key: String, table: String, file: StaticString = #filePath, line: UInt = #line) -> String {
		let bundle = Bundle(for: TorrentsPresenter.self)
		let value = bundle.localizedString(forKey: key, value: nil, table: table)
		if value == key {
			XCTFail("Missing localized string for key: \(key) in table: \(table)", file: file, line: line)
		}
		return value
	}
}
