//
//  SpeedSettingsPresenterTests.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 25/08/23.
//

import XCTest
import Transmission

final class SpeedSettingsPresenterTests: XCTestCase {
	
	private let table = "SpeedSettings"
	
	func test_title_isLocalized() {
		XCTAssertEqual(SpeedSettingsPagePresenter.title, localized("TITLE", table: table))
	}
	
	func test_map_createsViewModel() {
		let altSpeedDown = 100
		let altSpeedTimeBegin = 100
		let altSpeedTimeDay = 100
		let altSpeedTimeEnabled = false
		let altSpeedTimeEnd = 100
		let altSpeedUp = 100
		let speedLimitDownEnabled = true
		let speedLimitDown = 100
		let speedLimitUpEnabled = false
		let speedLimitUp = 100
		
		let viewModel = SpeedSettingsPagePresenter.map(SpeedSettings(
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
		))
		
		XCTAssertEqual(viewModel.alternativeDownloadLimit, "100")
		XCTAssertEqual(viewModel.alternativeSpeedTimeBegin, "100")
		XCTAssertEqual(viewModel.alternativeSpeedTimeDay, "100")
		XCTAssertEqual(viewModel.scheduledTimesEnabled, false)
		XCTAssertEqual(viewModel.alternativeSpeedTimeEnd, "100")
		XCTAssertEqual(viewModel.alternativeUploadLimit, "100")
		XCTAssertEqual(viewModel.downloadLimitEnabled, true)
		XCTAssertEqual(viewModel.downloadLimit, "100")
		XCTAssertEqual(viewModel.uploadLimitEnabled, false)
		XCTAssertEqual(viewModel.uploadLimit, "100")
		
	}
	
}
