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
	
	public static func map(_ speedSettings: SpeedSettings) -> SpeedSettingsPageViewModel {
		SpeedSettingsPageViewModel(
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
