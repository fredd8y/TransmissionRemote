//
//  TorrentsSettingsGetMapperTests.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 22/08/23.
//

import XCTest
import Foundation
import Transmission

class TorrentsSettingsGetMapperTests: XCTestCase {
	func test_map_throwsErrorOnNon200HTTPResponse() throws {
		let json = makeJSON(fromDictionary: [:])
		let samples = [199, 201, 300, 408, 500]
		
		try samples.forEach { code in
			XCTAssertThrowsError(
				try TorrentsSettingsGetMapper.map(json, from: HTTPURLResponse(statusCode: code))
			)
		}
	}
	
	func test_map_throwsErrorOn200HTTPResponseWithInvalidJSON() {
		let json = Data("invalid json".utf8)
		
		XCTAssertThrowsError(
			try TorrentsSettingsGetMapper.map(json, from: HTTPURLResponse(statusCode: 200))
		)
	}
	
	func test_map_throwsErrorOn200HTTPResponseWithEmptyJSON() throws {
		XCTAssertThrowsError(
			try TorrentsSettingsGetMapper.map(Data(), from: HTTPURLResponse(statusCode: 200))
		)
	}
	
	func test_map_deliversStatsOn200HTTPResponseWithValidJSON() {
		let torrentsSettings = makeTorrentsSettings()
		
		let json = makeJSON(fromDictionary: torrentsSettings.json)
		
		do {
			let result = try TorrentsSettingsGetMapper.map(json, from: HTTPURLResponse(statusCode: 200))
			
			XCTAssertEqual(result, torrentsSettings.model)
		} catch {
			XCTFail("Expected no exception, got \(error.localizedDescription) instead")
		}
	}
	
	// MARK: - Helpers
	
	private func makeTorrentsSettings() -> (model: TorrentsSettings, json: [String: Any]) {
		let downloadDir = "a download dir"
		let startAddedTorrents = true
		let renamePartialFiles = true
		let seedRatioLimited = true
		let seedRatioLimit = 3
		let idleSeedingLimitedEnabled = true
		let idleSeedingLimit = 20
		
		let torrentsSettings = TorrentsSettings(
			downloadDir: downloadDir,
			startAddedTorrents: startAddedTorrents,
			renamePartialFiles: renamePartialFiles,
			seedRatioLimited: seedRatioLimited,
			seedRatioLimit: seedRatioLimit,
			idleSeedingLimitedEnabled: idleSeedingLimitedEnabled,
			idleSeedingLimit: idleSeedingLimit
		)
		
		let json: [String: Any] = [
			"arguments": [
				"download-dir": downloadDir,
				"start-added-torrents": startAddedTorrents,
				"rename-partial-files": renamePartialFiles,
				"seed-ratio-limited": seedRatioLimited,
				"seed-ratio-limit": seedRatioLimit,
				"idle-seeding-limited-enabled": idleSeedingLimitedEnabled,
				"idle-seeding-limit": idleSeedingLimit
			]
		]
		
		return (torrentsSettings, json)
	}
}
