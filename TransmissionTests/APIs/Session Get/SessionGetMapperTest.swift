//
//  SessionGetMapperTest.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 14/05/23.
//

import XCTest
import Transmission

class SessionGetMapperTest: XCTestCase {
	func test_map_throwsErrorOnHTTPResponseStatusCodeDifferentThan200And409() throws {
		let json = makeItemsJSON(withArguments: [], andResult: anyString())
		let samples = [199, 201, 300, 408, 410, 500]
		
		try samples.forEach { code in
			XCTAssertThrowsError(
				try SessionGetMapper.map(json, from: HTTPURLResponse(statusCode: code))
			)
		}
	}
	
	func test_map_throwsErrorOn200Or409ResponseWithInvalidJSON() throws {
		let invalidJson = Data("invalid json".utf8)
		let samples = [200, 409]
		
		try samples.forEach { code in
			XCTAssertThrowsError(
				try SessionGetMapper.map(invalidJson, from: HTTPURLResponse(statusCode: code))
			)
		}
	}
	
	func test_map_throwsSessionIdErrorOn409HTTPResponse() throws {
		let json = makeItemsJSON(withArguments: [], andResult: anyString())
		let sessionIdValue = anyString()
		do {
			try SessionGetMapper.map(
				json,
				from: HTTPURLResponse(statusCode: 409, headerFields: [SessionGetMapper.sessionIdKey: sessionIdValue])
			)
		} catch {
			guard let _error = error as? SessionGetMapper.Error else {
				XCTFail("Expected SessionGetMapper.Error value, got \(error.self) instead")
				return
			}
			if case let SessionGetMapper.Error.missingSessionId(sessionId) = _error {
				if let retrievedSessionIdValue = sessionId as? String {
					XCTAssertEqual(sessionIdValue, retrievedSessionIdValue)
				} else {
					XCTFail("Expected String sessionIdValue value, got \(String(describing: sessionId)) instead")
				}
			} else {
				XCTFail("Expected SessionGetMapper.Error.missingSessionId value, got \(error.self) instead")
			}
		}
		
	}
	
	// MARK: - Helpers
	
	func makeItemsJSON(withArguments arguments: [[String: Any]], andResult result: String) -> Data {
		let json: [String: Any] = ["arguments": arguments, "result": result]
		return try! JSONSerialization.data(withJSONObject: json)
	}
}
