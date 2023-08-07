//
//  TorrentBodiesTests.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 15/05/23.
//

import XCTest
import Transmission

final class TorrentBodiesTests: XCTestCase {
	
	func test_torrentGet_httpBody() {
		let expectedBody = #"{"method": "torrent-get"}"#
		
		let httpBody = TorrentBodies.get
		
		XCTAssertEqual(expectedBody, httpBody)
	}
	
}
