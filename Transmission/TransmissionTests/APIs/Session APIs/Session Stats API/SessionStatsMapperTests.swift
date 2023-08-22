//
//  SessionStatsMapperTests.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 15/07/23.
//


import XCTest
import Foundation
import Transmission

class SessionStatsMapperTests: XCTestCase {
	func test_map_throwsErrorOnNon200HTTPResponse() throws {
		let json = makeJSON(fromDictionary: [:])
		let samples = [199, 201, 300, 408, 500]
		
		try samples.forEach { code in
			XCTAssertThrowsError(
				try SessionStatsMapper.map(json, from: HTTPURLResponse(statusCode: code))
			)
		}
	}
	
	func test_map_throwsErrorOn200HTTPResponseWithInvalidJSON() {
		let json = Data("invalid json".utf8)
		
		XCTAssertThrowsError(
			try SessionStatsMapper.map(json, from: HTTPURLResponse(statusCode: 200))
		)
	}
	
	func test_map_throwsErrorOn200HTTPResponseWithEmptyJSON() throws {
		XCTAssertThrowsError(
			try SessionStatsMapper.map(Data(), from: HTTPURLResponse(statusCode: 200))
		)
	}
	
	func test_map_deliversStatsOn200HTTPResponseWithValidJSON() {
		let stats = makeStats()
		
		let json = makeJSON(fromDictionary: stats.json)
		
		do {
			let result = try SessionStatsMapper.map(json, from: HTTPURLResponse(statusCode: 200))
			
			XCTAssertEqual(result, stats.model)
		} catch {
			XCTFail("Expected no exception, got \(error.localizedDescription) instead")
		}
	}
	
	// MARK: - Helpers
	
	private func makeStats() -> (model: Stats, json: [String: Any]) {
		makeStats(activeTorrentCount: Int.random(in: 0..<10), downloadSpeed: Int.random(in: 1_000..<10_000_000))
	}
}
