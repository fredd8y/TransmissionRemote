//
//  SpeedSettingsPageViewModel+Factory.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 25/08/23.
//

import Foundation
import Transmission

extension SpeedSettingsPageViewModel {
	static func loading() -> SpeedSettingsPageViewModel {
		SpeedSettingsPageViewModel(
			isLoading: true,
			errorMessage: nil,
			uploadLimitEnabled: false,
			uploadLimit: "-",
			uploadLimitError: false,
			downloadLimitEnabled: false,
			downloadLimit: "-",
			downloadLimitError: false,
			alternativeUploadLimit: "-",
			alternativeUploadLimitError: false,
			alternativeDownloadLimit: "-",
			alternativeDownloadLimitError: false,
			scheduledTimesEnabled: false,
			alternativeSpeedTimeBegin: .hour0000,
			alternativeSpeedTimeDay: .everyday,
			alternativeSpeedTimeEnd: .hour0000
		)
	}
	
	static func error(_ errorMessage: String) -> SpeedSettingsPageViewModel {
		SpeedSettingsPageViewModel(
			isLoading: false,
			errorMessage: errorMessage,
			uploadLimitEnabled: false,
			uploadLimit: "-",
			uploadLimitError: false,
			downloadLimitEnabled: false,
			downloadLimit: "-",
			downloadLimitError: false,
			alternativeUploadLimit: "-",
			alternativeUploadLimitError: false,
			alternativeDownloadLimit: "-",
			alternativeDownloadLimitError: false,
			scheduledTimesEnabled: false,
			alternativeSpeedTimeBegin: .hour0000,
			alternativeSpeedTimeDay: .everyday,
			alternativeSpeedTimeEnd: .hour0000
		)
	}
}
