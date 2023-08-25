//
//  SpeedSettingsGetMapperTests.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 25/08/23.
//


import XCTest
import Foundation
import Transmission

class SpeedSettingsGetMapperTests: XCTestCase {
	func test_map_throwsErrorOnNon200HTTPResponse() throws {
		let json = makeJSON(fromDictionary: [:])
		let samples = [199, 201, 300, 408, 500]
		
		try samples.forEach { code in
			XCTAssertThrowsError(
				try SpeedSettingsGetMapper.map(json, from: HTTPURLResponse(statusCode: code))
			)
		}
	}
	
	func test_map_throwsErrorOn200HTTPResponseWithInvalidJSON() {
		let json = Data("invalid json".utf8)
		
		XCTAssertThrowsError(
			try SpeedSettingsGetMapper.map(json, from: HTTPURLResponse(statusCode: 200))
		)
	}
	
	func test_map_throwsErrorOn200HTTPResponseWithEmptyJSON() throws {
		XCTAssertThrowsError(
			try SpeedSettingsGetMapper.map(Data(), from: HTTPURLResponse(statusCode: 200))
		)
	}
	
	func test_map_deliversStatsOn200HTTPResponseWithValidJSON() {
		let speedSetting = makespeedSettings()
		
		let json = makeJSON(fromDictionary: speedSetting.json)
		
		do {
			let result = try SpeedSettingsGetMapper.map(json, from: HTTPURLResponse(statusCode: 200))
			
			XCTAssertEqual(result, speedSetting.model)
		} catch {
			XCTFail("Expected no exception, got \(error.localizedDescription) instead")
		}
	}
	
	// MARK: - Helpers
	
	private func makespeedSettings() -> (model: SpeedSettings, json: [String: Any]) {
		let altSpeedDown = 100
		let altSpeedTimeBegin = 100
		let altSpeedTimeDay = 100
		let altSpeedTimeEnabled = false
		let altSpeedTimeEnd = 100
		let altSpeedUp = 100
		let speedLimitDownEnabled = false
		let speedLimitDown = 100
		let speedLimitUpEnabled = false
		let speedLimitUp = 100
		
		let speedSettings = SpeedSettings(
			altSpeedDown: altSpeedDown,
			altSpeedTimeBegin: altSpeedTimeBegin,
			altSpeedTimeDay: altSpeedTimeDay,
			altSpeedTimeEnabled: altSpeedTimeEnabled,
			altSpeedTimeEnd: altSpeedTimeEnd,
			altSpeedUp: altSpeedUp,
			speedLimitDownEnabled: speedLimitDownEnabled,
			speedLimitDown: speedLimitDown,
			speedLimitUpEnabled: speedLimitUpEnabled,
			speedLimitUp: speedLimitUp
		)

		let json: [String: Any] = [
			"arguments": [
				"alt-speed-down": altSpeedDown,
				"alt-speed-time-begin": altSpeedTimeBegin,
				"alt-speed-time-day": altSpeedTimeDay,
				"alt-speed-time-enabled": altSpeedTimeEnabled,
				"alt-speed-time-end": altSpeedTimeEnd,
				"alt-speed-up": altSpeedUp,
				"speed-limit-down-enabled": speedLimitDownEnabled,
				"speed-limit-down": speedLimitDown,
				"speed-limit-up-enabled": speedLimitUpEnabled,
				"speed-limit-up": speedLimitUp			]
		]
		
		return (speedSettings, json)
	}
}
