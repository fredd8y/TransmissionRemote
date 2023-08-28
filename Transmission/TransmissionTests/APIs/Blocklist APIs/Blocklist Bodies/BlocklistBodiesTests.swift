//
//  BlocklistBodiesTests.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 28/08/23.
//

import XCTest
import Transmission

final class BlocklistBodiesTests: XCTestCase {
	
	func test_blocklistUpdate_httpBody() {
		let expectedBody = #"{"method": "blocklist-update"}"#.data(using: .utf8)!
		
		let httpBody = BlocklistBodies.update
		
		XCTAssertEqual(expectedBody, httpBody)
	}
	
}
