//
//  TorrentAddMapperTests.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 03/08/23.
//

import XCTest
import Transmission

class TorrentAddMapperTests: XCTestCase {
	
	func test_map_throwsErrorOnNon200HTTPResponse() throws {
		let json = makeJSON(fromDictionary: [:])
		let samples = [199, 201, 300, 408, 500]
		
		try samples.forEach { code in
			XCTAssertThrowsError(
				try TorrentAddMapper.map(json, from: HTTPURLResponse(statusCode: code))
			)
		}
	}
	
}
