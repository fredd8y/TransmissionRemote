//
//  BlocklistUpdateMapperTests.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 28/08/23.
//


import XCTest
import Transmission

class BlocklistUpdateMapperTests: XCTestCase {
	
	func test_map_throwsErrorOnNon200HTTPResponse() throws {
		let json = makeJSON(fromDictionary: [:])
		let samples = [199, 201, 300, 408, 500]
		
		try samples.forEach { code in
			XCTAssertThrowsError(
				try BlocklistUpdateMapper.map(json, from: HTTPURLResponse(statusCode: code))
			)
		}
	}
	
	func test_map_throwsErrorOnResponseWithoutSuccessResult() throws {
		let (json, apiError) = makeResponseWithFailure()
		
		let jsonData = makeJSON(fromDictionary: json)
		
		do {
			_ = try BlocklistUpdateMapper.map(jsonData, from: HTTPURLResponse(statusCode: 200))
		} catch {
			if case let BlocklistUpdateMapper.Error.failed(explanation) = error {
				XCTAssertEqual(explanation, apiError)
			} else {
				XCTFail("Expected BlocklistUpdateMapper.Error.failed, got \(error) instead")
			}
		}
	}
	
	func test_map_returnSizeWithCorrectJson() throws {
		let (json, size) = makeCorrectResponse()
		
		let jsonData = makeJSON(fromDictionary: json)
		
		guard let retrievedSize = try? BlocklistUpdateMapper.map(jsonData, from: HTTPURLResponse(statusCode: 200)) else {
			XCTFail("Expected success")
			return
		}
		
		XCTAssertEqual(retrievedSize, size)
	}
	
	// MARK: - Helpers
	
	private func makeResponseWithFailure() -> (json: [String: Any], error: String) {
		let error = "failed for some reason"
		
		let json: [String: Any] = [
			"result": error,
			"arguments": [:]
		]
		return (json, error)
	}
	
	private func makeCorrectResponse() -> (json: [String: Any], size: Int) {
		let size = 123456789
		
		let json: [String: Any] = [
			"result": "success",
			"arguments": [
				"blocklist-size": size
			]
		]
		
		return (json, size)
	}
	
}
