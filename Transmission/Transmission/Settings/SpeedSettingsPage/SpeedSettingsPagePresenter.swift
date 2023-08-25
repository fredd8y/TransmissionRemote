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
			alternativeSpeedTimeBegin: speedSettings.altSpeedTimeBegin.description,
			alternativeSpeedTimeDay: speedSettings.altSpeedTimeDay.description,
			alternativeSpeedTimeEnd: speedSettings.altSpeedTimeEnd.description
		)
	}
	
}
