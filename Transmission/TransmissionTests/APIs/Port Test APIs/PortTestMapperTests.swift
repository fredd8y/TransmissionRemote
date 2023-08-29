//
//  PortTestMapperTests.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 29/08/23.
//

import XCTest
import Transmission

class PortTestMapperTests: XCTestCase {
	
	func test_map_throwsErrorOnNon200HTTPResponse() throws {
		let json = makeJSON(fromDictionary: [:])
		let samples = [199, 201, 300, 408, 500]
		
		try samples.forEach { code in
			XCTAssertThrowsError(
				try PortTestMapper.map(json, from: HTTPURLResponse(statusCode: code))
			)
		}
	}
	
	func test_map_throwsErrorOn200HTTPResponseWithInvalidJSON() {
		let json = Data("invalid json".utf8)
		
		XCTAssertThrowsError(
			try PortTestMapper.map(json, from: HTTPURLResponse(statusCode: 200))
		)
	}
	
	func test_map_throwsErrorOn200HTTPResponseWithEmptyJSON() throws {
		XCTAssertThrowsError(
			try PortTestMapper.map(Data(), from: HTTPURLResponse(statusCode: 200))
		)
	}
	
	func test_map_deliversOn200HTTPResponseWithValidJSON_open() {
		let portTest = makePortTestOpen(true)
		
		let json = makeJSON(fromDictionary: portTest.json)
		
		do {
			let result = try PortTestMapper.map(json, from: HTTPURLResponse(statusCode: 200))
			
			XCTAssertEqual(result, portTest.portIsOpen)
		} catch {
			XCTFail("Expected no exception, got \(error.localizedDescription) instead")
		}
	}
	
	func test_map_deliversOn200HTTPResponseWithValidJSON_closed() {
		let portTest = makePortTestOpen(false)
		
		let json = makeJSON(fromDictionary: portTest.json)
		
		do {
			let result = try PortTestMapper.map(json, from: HTTPURLResponse(statusCode: 200))
			
			XCTAssertEqual(result, portTest.portIsOpen)
		} catch {
			XCTFail("Expected no exception, got \(error.localizedDescription) instead")
		}
	}
	
	// MARK: - Helpers
	
	private func makePortTestOpen(_ open: Bool) -> (json: [String: Any], portIsOpen: Bool) {
		let json: [String: Any] = [
			"result": "success",
			"arguments": [
				"port-is-open": open
			]
		]
		return (json, open)
	}
	
}
