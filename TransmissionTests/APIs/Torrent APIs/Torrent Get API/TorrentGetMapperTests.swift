//
//  TorrentGetMapperTests.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 16/05/23.
//

import XCTest
import Transmission

class TorrentGetMapperTests: XCTestCase {
	func test_map_throwsErrorOnNon200HTTPResponse() throws {
		let json = makeJSON(fromDictionary: [:])
		let samples = [199, 201, 300, 408, 500]
		
		try samples.forEach { code in
			XCTAssertThrowsError(
				try TorrentGetMapper.map(json, from: HTTPURLResponse(statusCode: code))
			)
		}
	}
	
	func test_map_throwsErrorOn200HTTPResponseWithInvalidJson() throws {
		let json = Data("invalid json".utf8)
		
		XCTAssertThrowsError(
			try TorrentGetMapper.map(json, from: HTTPURLResponse(statusCode: 200))
		)
	}
	
	// MARK: - Helpers

	private func makeJSON(fromDictionary dictionary: [String: Any]) -> Data {
		return try! JSONSerialization.data(withJSONObject: dictionary)
	}
}
