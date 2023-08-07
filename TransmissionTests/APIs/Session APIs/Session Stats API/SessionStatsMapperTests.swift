//
//  SessionStatsMapperTests.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 15/07/23.
//

import Foundation

import XCTest
import Transmission

class SessionStatsMapperTests: XCTestCase {
	func test_map_throwsErrorOnNon200HTTPResponse() throws {
		let samples = [199, 201, 300, 408, 500]
		
		try samples.forEach { code in
			XCTAssertThrowsError(
				try SessionStatsMapper.map(from: HTTPURLResponse(statusCode: code))
			)
		}
	}
}
