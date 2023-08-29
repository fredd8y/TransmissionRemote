//
//  NetworkSettingsGetMapperTests.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 29/08/23.
//

import XCTest
import Foundation
import Transmission

class NetworkSettingsGetMapperTests: XCTestCase {
	func test_map_throwsErrorOnNon200HTTPResponse() throws {
		let json = makeJSON(fromDictionary: [:])
		let samples = [199, 201, 300, 408, 500]
		
		try samples.forEach { code in
			XCTAssertThrowsError(
				try NetworkSettingsGetMapper.map(json, from: HTTPURLResponse(statusCode: code))
			)
		}
	}
	
	func test_map_throwsErrorOn200HTTPResponseWithInvalidJSON() {
		let json = Data("invalid json".utf8)
		
		XCTAssertThrowsError(
			try NetworkSettingsGetMapper.map(json, from: HTTPURLResponse(statusCode: 200))
		)
	}
	
	func test_map_throwsErrorOn200HTTPResponseWithEmptyJSON() throws {
		XCTAssertThrowsError(
			try NetworkSettingsGetMapper.map(Data(), from: HTTPURLResponse(statusCode: 200))
		)
	}
	
	func test_map_deliversOn200HTTPResponseWithValidJSON() {
		let torrentsSettings = makeTorrentsSettings()
		
		let json = makeJSON(fromDictionary: torrentsSettings.json)
		
		do {
			let result = try NetworkSettingsGetMapper.map(json, from: HTTPURLResponse(statusCode: 200))
			
			XCTAssertEqual(result, torrentsSettings.model)
		} catch {
			XCTFail("Expected no exception, got \(error.localizedDescription) instead")
		}
	}
	
	// MARK: - Helpers
	
	private func makeTorrentsSettings() -> (model: NetworkSettings, json: [String: Any]) {
		let peerPort = 51413
		let peerPortRandomOnStart = false
		let portForwardingEnabled = false
		let utpEnabled = true
		
		let networkSettings = NetworkSettings(
			peerPort: peerPort,
			peerPortRandomOnStart: peerPortRandomOnStart,
			portForwardingEnabled: portForwardingEnabled,
			utpEnabled: utpEnabled
		)

		let json: [String: Any] = [
			"arguments": [
				"peer-port": peerPort,
				"peer-port-random-on-start": peerPortRandomOnStart,
				"port-forwarding-enabled": portForwardingEnabled,
				"utp-enabled": utpEnabled
			]
		]
		
		return (networkSettings, json)
	}
}

