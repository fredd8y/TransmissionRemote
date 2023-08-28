//
//  PeersSettingsGetMapperTests.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 28/08/23.
//

import XCTest
import Foundation
import Transmission

class PeersSettingsGetMapperTests: XCTestCase {
	func test_map_throwsErrorOnNon200HTTPResponse() throws {
		let json = makeJSON(fromDictionary: [:])
		let samples = [199, 201, 300, 408, 500]
		
		try samples.forEach { code in
			XCTAssertThrowsError(
				try PeersSettingsGetMapper.map(json, from: HTTPURLResponse(statusCode: code))
			)
		}
	}
	
	func test_map_throwsErrorOn200HTTPResponseWithInvalidJSON() {
		let json = Data("invalid json".utf8)
		
		XCTAssertThrowsError(
			try PeersSettingsGetMapper.map(json, from: HTTPURLResponse(statusCode: 200))
		)
	}
	
	func test_map_throwsErrorOn200HTTPResponseWithEmptyJSON() throws {
		XCTAssertThrowsError(
			try PeersSettingsGetMapper.map(Data(), from: HTTPURLResponse(statusCode: 200))
		)
	}
	
	func test_map_deliversStatsOn200HTTPResponseWithValidJSON() {
		let torrentsSettings = makeTorrentsSettings()
		
		let json = makeJSON(fromDictionary: torrentsSettings.json)
		
		do {
			let result = try PeersSettingsGetMapper.map(json, from: HTTPURLResponse(statusCode: 200))
			
			XCTAssertEqual(result, torrentsSettings.model)
		} catch {
			XCTFail("Expected no exception, got \(error.localizedDescription) instead")
		}
	}
	
	// MARK: - Helpers
	
	private func makeTorrentsSettings() -> (model: PeersSettings, json: [String: Any]) {
		let peerLimitGlobal: Int = 500
		let peerLimitPerTorrent: Int = 24
		let pexEnabled: Bool = false
		let dhtEnabled: Bool = true
		let lpdEnabled: Bool = false
		let blocklistEnabled: Bool = false
		let blocklistSize: Int = 123456
		let blocklistUrl: String = "a url"
		let encryption: PeersSettings.Encryption = .preferred
		
		let peersSettings = PeersSettings(
			peerLimitGlobal: peerLimitGlobal,
			peerLimitPerTorrent: peerLimitPerTorrent,
			pexEnabled: pexEnabled,
			dhtEnabled: dhtEnabled,
			lpdEnabled: lpdEnabled,
			blocklistEnabled: blocklistEnabled,
			blocklistSize: blocklistSize,
			blocklistUrl: blocklistUrl,
			encryption: encryption
		)

		let json: [String: Any] = [
			"arguments": [
				"peer-limit-global": peerLimitGlobal,
				"peer-limit-per-torrent": peerLimitPerTorrent,
				"pex-enabled": pexEnabled,
				"dht-enabled": dhtEnabled,
				"lpd-enabled": lpdEnabled,
				"blocklist-enabled": blocklistEnabled,
				"blocklist-size": blocklistSize,
				"blocklist-url": blocklistUrl,
				"encryption": encryption.rawValue
			]
		]
		
		return (peersSettings, json)
	}
}
