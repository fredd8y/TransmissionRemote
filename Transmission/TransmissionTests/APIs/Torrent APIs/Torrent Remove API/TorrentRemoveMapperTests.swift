//
//  TorrentRemoveMapperTests.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 03/08/23.
//

import XCTest
import Transmission

class TorrentRemoveMapperTests: XCTestCase {
	
	func test_map_throwsErrorOnNon200HTTPResponse() throws {
		let json = makeJSON(fromDictionary: [:])
		let samples = [199, 201, 300, 408, 500]
		
		try samples.forEach { code in
			XCTAssertThrowsError(
				try TorrentRemoveMapper.map(json, from: HTTPURLResponse(statusCode: code))
			)
		}
	}
	
	func test_map_throwsErrorOnResponseWithoutSuccessResult() throws {
		let (json, apiError) = makeResponseWithFailure()
		
		let jsonData = makeJSON(fromDictionary: json)
		
		do {
			_ = try TorrentRemoveMapper.map(jsonData, from: HTTPURLResponse(statusCode: 200))
		} catch {
			if case let TorrentRemoveMapper.Error.failed(explanation) = error {
				XCTAssertEqual(explanation, apiError)
			} else {
				XCTFail("Expected TorrentRemoveMapper.Error.failed, got \(error) instead")
			}
		}
	}
	
	// MARK: - Helpers
	
	private func makeResponseWithFailure() -> (json: [String: Any], error: String) {
		let error = "failed for some reason"
		
		let json: [String: Any] = [
			"result": error
		]
		return (json, error)
	}
	
	
}
