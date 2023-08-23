//
//  TorrentsSettingsPageViewModel+Factory.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 22/08/23.
//

import Foundation
import Transmission

extension TorrentsSettingsPageViewModel {
	static func loading() -> TorrentsSettingsPageViewModel {
		TorrentsSettingsPageViewModel(
			downloadDir: "-",
			startAddedTorrents: false,
			renamePartialFiles: false,
			seedRatioLimited: false,
			seedRatioLimit: "-",
			idleSeedingLimitEnabled: false,
			idleSeedingLimit: "-",
			errorMessage: nil,
			isLoading: true,
			seedRatioLimitError: false,
			idleSeedingLimitError: false
		)
	}
	static func error(_ errorMessage: String) -> TorrentsSettingsPageViewModel {
		TorrentsSettingsPageViewModel(
			downloadDir: "-",
			startAddedTorrents: false,
			renamePartialFiles: false,
			seedRatioLimited: false,
			seedRatioLimit: "-",
			idleSeedingLimitEnabled: false,
			idleSeedingLimit: "-",
			errorMessage: errorMessage,
			isLoading: false,
			seedRatioLimitError: false,
			idleSeedingLimitError: false
		)
	}
}
