//
//  SharedPresentationHelpers.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 19/07/23.
//

import XCTest
import Transmission

extension XCTestCase {
	func localized(_ key: String, table: String, file: StaticString = #filePath, line: UInt = #line) -> String {
		let bundle = Bundle(for: TorrentsPresenter.self)
		let value = bundle.localizedString(forKey: key, value: nil, table: table)
		if value == key {
			XCTFail("Missing localized string for key: \(key) in table: \(table)", file: file, line: line)
		}
		return value
	}
}
