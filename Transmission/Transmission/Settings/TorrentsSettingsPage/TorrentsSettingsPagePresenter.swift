//
//  TorrentsSettingsPagePresenter.swift
//  Transmission
//
//  Created by Federico Arvat on 22/08/23.
//

import Foundation

import Foundation

public class TorrentsSettingsPagePresenter {
	public static var title: String {
		NSLocalizedString(
			"TORRENTS_SETTINGS_PAGE_TITLE",
			tableName: "TorrentsSettings",
			bundle: Bundle(for: TorrentsSettingsPagePresenter.self),
			comment: "Torrents settings page title")
	}
	
	public static func map(_ torrentsSettings: TorrentsSettings) -> TorrentsSettingsPageViewModel {
		TorrentsSettingsPageViewModel(
			downloadDir: torrentsSettings.downloadDir,
			startAddedTorrents: torrentsSettings.startAddedTorrents,
			renamePartialFiles: torrentsSettings.renamePartialFiles,
			seedRatioLimited: torrentsSettings.seedRatioLimited,
			seedRatioLimit: torrentsSettings.seedRatioLimit.description,
			idleSeedingLimitEnabled: torrentsSettings.idleSeedingLimitEnabled,
			idleSeedingLimit: torrentsSettings.idleSeedingLimit.description,
			errorMessage: nil,
			isLoading: false
		)
	}
}
