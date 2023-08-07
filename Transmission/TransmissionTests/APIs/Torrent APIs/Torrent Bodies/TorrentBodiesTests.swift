//
//  TorrentBodiesTests.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 15/05/23.
//

import XCTest
import Transmission

final class TorrentBodiesTests: XCTestCase {
	func test_torrentGet_httpBodyWithEmptyFields() {
		let expectedBody = #"{"method":"torrent-get","arguments":{"fields":[]}}"#.data(using: .utf8)
		
		let httpBody = TorrentBodies.get([])
		
		XCTAssertEqual(expectedBody, httpBody)
	}
	
	
	func test_torrentGet_httpBodyWithFields() {
		let expectedBody = #"{"method":"torrent-get","arguments":{"fields":["field1","field2","field3"]}}"#.data(using: .utf8)
		
		let httpBody = TorrentBodies.get(["field1", "field2", "field3"])
		
		XCTAssertEqual(expectedBody, httpBody)
	}
}
