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
	
	public static func map(
		downloadDir: String,
		startAddedTorrents: Bool,
		renamePartialFiles: Bool,
		seedRatioLimited: Bool,
		seedRatioLimit: Int,
		idleSeedingLimitedEnabled: Bool,
		idleSeedingLimit: Int
	) -> TorrentsSettingsPageViewModel {
		TorrentsSettingsPageViewModel(
			downloadDir: downloadDir,
			startAddedTorrents: startAddedTorrents,
			renamePartialFiles: renamePartialFiles,
			seedRatioLimited: seedRatioLimited,
			seedRatioLimit: seedRatioLimit.description,
			idleSeedingLimitedEnabled: idleSeedingLimitedEnabled,
			idleSeedingLimit: idleSeedingLimit.description
		)
	}
}
