//
//  SpeedSettingsPagePresenter.swift
//  Transmission
//
//  Created by Federico Arvat on 25/08/23.
//

import Foundation

public class SpeedSettingsPagePresenter {
	
	public static var title: String {
		NSLocalizedString(
			"TITLE",
			tableName: "SpeedSettings",
			bundle: Bundle(for: SpeedSettingsPagePresenter.self),
			comment: "Torrents settings page title")
	}
	
	public static var speedLimitsHeader: String {
		NSLocalizedString(
			"SPEED_LIMITS_HEADER",
			tableName: "SpeedSettings",
			bundle: Bundle(for: SpeedSettingsPagePresenter.self),
			comment: "Speed limits header title")
	}
	
	public static var uploadToggleTitle: String {
		NSLocalizedString(
			"UPLOAD_TOGGLE_TITLE",
			tableName: "SpeedSettings",
			bundle: Bundle(for: SpeedSettingsPagePresenter.self),
			comment: "Upload toggle title")
	}
	
	public static var mustBeANumberError: String {
		NSLocalizedString(
			"MUST_BE_A_NUMBER_ERROR",
			tableName: "SpeedSettings",
			bundle: Bundle(for: SpeedSettingsPagePresenter.self),
			comment: "Must be a number error")
	}
	
	public static var downloadToggleTitle: String {
		NSLocalizedString(
			"DOWNLOAD_TOGGLE_TITLE",
			tableName: "SpeedSettings",
			bundle: Bundle(for: SpeedSettingsPagePresenter.self),
			comment: "Download toggle title")
	}
	
	public static var alternativeSpeedLimitsHeader: String {
		NSLocalizedString(
			"ALTERNATIVE_SPEED_LIMITS_HEADER",
			tableName: "SpeedSettings",
			bundle: Bundle(for: SpeedSettingsPagePresenter.self),
			comment: "Alternative speed limits header title")
	}
	
	public static var alternativeSpeedDescription: String {
		NSLocalizedString(
			"ALTERNATIVE_SPEED_DESCRIPTION",
			tableName: "SpeedSettings",
			bundle: Bundle(for: SpeedSettingsPagePresenter.self),
			comment: "Alternative speed description")
	}
	
	public static var confirm: String {
		NSLocalizedString(
			"CONFIRM",
			tableName: "SpeedSettings",
			bundle: Bundle(for: SpeedSettingsPagePresenter.self),
			comment: "Confirm button title")
	}
	
	public static var everyday: String {
		NSLocalizedString(
			"EVERYDAY",
			tableName: "SpeedSettings",
			bundle: Bundle(for: SpeedSettingsPagePresenter.self),
			comment: "everyday description")
	}
	
	public static var weekdays: String {
		NSLocalizedString(
			"WEEKDAYS",
			tableName: "SpeedSettings",
			bundle: Bundle(for: SpeedSettingsPagePresenter.self),
			comment: "weekdays description")
	}
	
	public static var weekends: String {
		NSLocalizedString(
			"WEEKENDS",
			tableName: "SpeedSettings",
			bundle: Bundle(for: SpeedSettingsPagePresenter.self),
			comment: "weekends description")
	}
	
	public static var sunday: String {
		NSLocalizedString(
			"SUNDAY",
			tableName: "SpeedSettings",
			bundle: Bundle(for: SpeedSettingsPagePresenter.self),
			comment: "sunday description")
	}
	
	public static var monday: String {
		NSLocalizedString(
			"MONDAY",
			tableName: "SpeedSettings",
			bundle: Bundle(for: SpeedSettingsPagePresenter.self),
			comment: "monday description")
	}
	
	public static var tuesday: String {
		NSLocalizedString(
			"TUESDAY",
			tableName: "SpeedSettings",
			bundle: Bundle(for: SpeedSettingsPagePresenter.self),
			comment: "tuesday description")
	}
	
	public static var wednesday: String {
		NSLocalizedString(
			"WEDNESDAY",
			tableName: "SpeedSettings",
			bundle: Bundle(for: SpeedSettingsPagePresenter.self),
			comment: "wednesday description")
	}
	
	public static var thursday: String {
		NSLocalizedString(
			"THURSDAY",
			tableName: "SpeedSettings",
			bundle: Bundle(for: SpeedSettingsPagePresenter.self),
			comment: "thursday description")
	}
	
	public static var friday: String {
		NSLocalizedString(
			"FRIDAY",
			tableName: "SpeedSettings",
			bundle: Bundle(for: SpeedSettingsPagePresenter.self),
			comment: "friday description")
	}
	
	public static var saturday: String {
		NSLocalizedString(
			"SATURDAY",
			tableName: "SpeedSettings",
			bundle: Bundle(for: SpeedSettingsPagePresenter.self),
			comment: "saturday description")
	}
	
	public static var scheduledTimes: String {
		NSLocalizedString(
			"SCHEDULED_TIMES",
			tableName: "SpeedSettings",
			bundle: Bundle(for: SpeedSettingsPagePresenter.self),
			comment: "scheduledTimes description")
	}
	
	public static var from: String {
		NSLocalizedString(
			"FROM",
			tableName: "SpeedSettings",
			bundle: Bundle(for: SpeedSettingsPagePresenter.self),
			comment: "from description")
	}
	
	public static var to: String {
		NSLocalizedString(
			"TO",
			tableName: "SpeedSettings",
			bundle: Bundle(for: SpeedSettingsPagePresenter.self),
			comment: "to description")
	}
	
	public static var onDays: String {
		NSLocalizedString(
			"ON_DAYS",
			tableName: "SpeedSettings",
			bundle: Bundle(for: SpeedSettingsPagePresenter.self),
			comment: "onDays description")
	}
	
	public static func map(_ speedSettings: SpeedSettings) -> SpeedSettingsPageViewModel {
		SpeedSettingsPageViewModel(
			isLoading: false,
			errorMessage: nil,
			uploadLimitEnabled: speedSettings.speedLimitUpEnabled,
			uploadLimit: speedSettings.speedLimitUp.description,
			uploadLimitError: false,
			downloadLimitEnabled: speedSettings.speedLimitDownEnabled,
			downloadLimit: speedSettings.speedLimitDown.description,
			downloadLimitError: false,
			alternativeUploadLimit: speedSettings.altSpeedUp.description,
			alternativeUploadLimitError: false,
			alternativeDownloadLimit: speedSettings.altSpeedDown.description,
			alternativeDownloadLimitError: false,
			scheduledTimesEnabled: speedSettings.altSpeedTimeEnabled,
			alternativeSpeedTimeBegin: speedSettings.altSpeedTimeBegin.speedSettingsHour ?? .hour0000,
			alternativeSpeedTimeDay: speedSettings.altSpeedTimeDay.speedSettingsDay ?? .everyday,
			alternativeSpeedTimeEnd: speedSettings.altSpeedTimeEnd.speedSettingsHour ?? .hour0000
		)
	}
	
}

private extension Int {
	var speedSettingsHour: SpeedSettingsHour? {
		return SpeedSettingsHour(rawValue: self)
	}
	
	var speedSettingsDay: SpeedSettingsDay? {
		return SpeedSettingsDay(rawValue: self)
	}
}
