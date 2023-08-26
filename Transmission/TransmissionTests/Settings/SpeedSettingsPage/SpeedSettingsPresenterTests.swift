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
	
	func test_speedLimitsHeader_isLocalized() {
		XCTAssertEqual(SpeedSettingsPagePresenter.speedLimitsHeader, localized("SPEED_LIMITS_HEADER", table: table))
	}
	
	func test_uploadToggleTitle_isLocalized() {
		XCTAssertEqual(SpeedSettingsPagePresenter.uploadToggleTitle, localized("UPLOAD_TOGGLE_TITLE", table: table))
	}
	
	func test_mustBeANumberError_isLocalized() {
		XCTAssertEqual(SpeedSettingsPagePresenter.mustBeANumberError, localized("MUST_BE_A_NUMBER_ERROR", table: table))
	}
	
	func test_downloadToggleTitle_isLocalized() {
		XCTAssertEqual(SpeedSettingsPagePresenter.downloadToggleTitle, localized("DOWNLOAD_TOGGLE_TITLE", table: table))
	}
	
	func test_alternativeSpeedLimitsHeader_isLocalized() {
		XCTAssertEqual(SpeedSettingsPagePresenter.alternativeSpeedLimitsHeader, localized("ALTERNATIVE_SPEED_LIMITS_HEADER", table: table))
	}
	
	func test_alternativeSpeedDescription_isLocalized() {
		XCTAssertEqual(SpeedSettingsPagePresenter.alternativeSpeedDescription, localized("ALTERNATIVE_SPEED_DESCRIPTION", table: table))
	}
	
	func test_confirm_isLocalized() {
		XCTAssertEqual(SpeedSettingsPagePresenter.confirm, localized("CONFIRM", table: table))
	}
	
	func test_everyday_islocalized() {
		XCTAssertEqual(SpeedSettingsPagePresenter.everyday, localized("EVERYDAY", table: table))
	}
	
	func test_weekdays_islocalized() {
		XCTAssertEqual(SpeedSettingsPagePresenter.weekdays, localized("WEEKDAYS", table: table))
	}
	
	func test_weekends_islocalized() {
		XCTAssertEqual(SpeedSettingsPagePresenter.weekends, localized("WEEKENDS", table: table))
	}
	
	func test_sunday_islocalized() {
		XCTAssertEqual(SpeedSettingsPagePresenter.sunday, localized("SUNDAY", table: table))
	}
	
	func test_monday_islocalized() {
		XCTAssertEqual(SpeedSettingsPagePresenter.monday, localized("MONDAY", table: table))
	}
	
	func test_tuesday_islocalized() {
		XCTAssertEqual(SpeedSettingsPagePresenter.tuesday, localized("TUESDAY", table: table))
	}
	
	func test_wednesday_islocalized() {
		XCTAssertEqual(SpeedSettingsPagePresenter.wednesday, localized("WEDNESDAY", table: table))
	}
	
	func test_thursday_islocalized() {
		XCTAssertEqual(SpeedSettingsPagePresenter.thursday, localized("THURSDAY", table: table))
	}
	
	func test_friday_islocalized() {
		XCTAssertEqual(SpeedSettingsPagePresenter.friday, localized("FRIDAY", table: table))
	}
	
	func test_saturday_islocalized() {
		XCTAssertEqual(SpeedSettingsPagePresenter.saturday, localized("SATURDAY", table: table))
	}
	
	func test_scheduledTimes_islocalized() {
		XCTAssertEqual(SpeedSettingsPagePresenter.scheduledTimes, localized("SCHEDULED_TIMES", table: table))
	}
	
	func test_from_islocalized() {
		XCTAssertEqual(SpeedSettingsPagePresenter.from, localized("FROM", table: table))
	}
	
	func test_to_islocalized() {
		XCTAssertEqual(SpeedSettingsPagePresenter.to, localized("TO", table: table))
	}
	
	func test_onDays_islocalized() {
		XCTAssertEqual(SpeedSettingsPagePresenter.onDays, localized("ON_DAYS", table: table))
	}
	
	func test_map_createsViewModel() {
		let altSpeedDown = 100
		let altSpeedTimeBegin = 15
		let altSpeedTimeDay = 1
		let altSpeedTimeEnabled = false
		let altSpeedTimeEnd = 75
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
		XCTAssertEqual(viewModel.alternativeSpeedTimeBegin, .hour0015)
		XCTAssertEqual(viewModel.alternativeSpeedTimeDay, .sunday)
		XCTAssertEqual(viewModel.scheduledTimesEnabled, false)
		XCTAssertEqual(viewModel.alternativeSpeedTimeEnd, .hour0115)
		XCTAssertEqual(viewModel.alternativeUploadLimit, "100")
		XCTAssertEqual(viewModel.downloadLimitEnabled, true)
		XCTAssertEqual(viewModel.downloadLimit, "100")
		XCTAssertEqual(viewModel.uploadLimitEnabled, false)
		XCTAssertEqual(viewModel.uploadLimit, "100")
		
	}
	
}
