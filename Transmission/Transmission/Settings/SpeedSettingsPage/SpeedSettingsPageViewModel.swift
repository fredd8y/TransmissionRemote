//
//  SpeedSettingsPageViewModel.swift
//  Transmission
//
//  Created by Federico Arvat on 25/08/23.
//

import SwiftUI

public class SpeedSettingsPageViewModel: ObservableObject {
	public init(
		isLoading: Bool,
		errorMessage: String?,
		uploadLimitEnabled: Bool,
		uploadLimit: String,
		uploadLimitError: Bool,
		downloadLimitEnabled: Bool,
		downloadLimit: String,
		downloadLimitError: Bool,
		alternativeUploadLimit: String,
		alternativeUploadLimitError: Bool,
		alternativeDownloadLimit: String,
		alternativeDownloadLimitError: Bool,
		scheduledTimesEnabled: Bool,
		alternativeSpeedTimeBegin: SpeedSettingsHour,
		alternativeSpeedTimeDay: SpeedSettingsDay,
		alternativeSpeedTimeEnd: SpeedSettingsHour
	) {
		self.isLoading = isLoading
		self.errorMessage = errorMessage
		self.uploadLimitEnabled = uploadLimitEnabled
		self.uploadLimit = uploadLimit
		self.uploadLimitError = uploadLimitError
		self.downloadLimitEnabled = downloadLimitEnabled
		self.downloadLimit = downloadLimit
		self.downloadLimitError = downloadLimitError
		self.alternativeUploadLimit = alternativeUploadLimit
		self.alternativeUploadLimitError = alternativeUploadLimitError
		self.alternativeDownloadLimit = alternativeDownloadLimit
		self.alternativeDownloadLimitError = alternativeDownloadLimitError
		self.scheduledTimesEnabled = scheduledTimesEnabled
		self.alternativeSpeedTimeBegin = alternativeSpeedTimeBegin
		self.alternativeSpeedTimeDay = alternativeSpeedTimeDay
		self.alternativeSpeedTimeEnd = alternativeSpeedTimeEnd
	}
	
	@Published public var isLoading: Bool
	@Published public var errorMessage: String?
	@Published public var uploadLimitEnabled: Bool
	@Published public var uploadLimit: String
	@Published public var uploadLimitError: Bool
	@Published public var downloadLimitEnabled: Bool
	@Published public var downloadLimit: String
	@Published public var downloadLimitError: Bool
	@Published public var alternativeUploadLimit: String
	@Published public var alternativeUploadLimitError: Bool
	@Published public var alternativeDownloadLimit: String
	@Published public var alternativeDownloadLimitError: Bool
	@Published public var scheduledTimesEnabled: Bool
	@Published public var alternativeSpeedTimeBegin: SpeedSettingsHour
	@Published public var alternativeSpeedTimeDay: SpeedSettingsDay
	@Published public var alternativeSpeedTimeEnd: SpeedSettingsHour
}
