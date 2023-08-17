//
//  TorrentDetailMapperTests.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 17/08/23.
//

import XCTest
import Transmission

class TorrentDetailMapperTests: XCTestCase {
	
	func test_map_throwsErrorOnNon200HTTPResponse() throws {
		let json = makeJSON(fromDictionary: [:])
		let samples = [199, 201, 300, 408, 500]
		
		try samples.forEach { code in
			XCTAssertThrowsError(
				try TorrentDetailMapper.map(json, from: HTTPURLResponse(statusCode: code))
			)
		}
	}
	
	func test_map_throwsErrorOn200HTTPResponseWithInvalidJson() throws {
		let json = Data("invalid json".utf8)
		
		XCTAssertThrowsError(
			try TorrentDetailMapper.map(json, from: HTTPURLResponse(statusCode: 200))
		)
	}
}

