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

	public static var downloadingHeader: String {
		NSLocalizedString(
			"DOWNLOADING_HEADER",
			tableName: "TorrentsSettings",
			bundle: Bundle(for: TorrentsSettingsPagePresenter.self),
			comment: "Downloading header")
	}

	public static var downloadTo: String {
		NSLocalizedString(
			"DOWNLOAD_TO",
			tableName: "TorrentsSettings",
			bundle: Bundle(for: TorrentsSettingsPagePresenter.self),
			comment: "Download to description")
	}

	public static var startWhenAdded: String {
		NSLocalizedString(
			"START_WHEN_ADDED",
			tableName: "TorrentsSettings",
			bundle: Bundle(for: TorrentsSettingsPagePresenter.self),
			comment: "Start when added description")
	}

	public static var incompleteFileNamesExtension: String {
		NSLocalizedString(
			"INCOMPLETE_FILE_NAMES_EXTENSION",
			tableName: "TorrentsSettings",
			bundle: Bundle(for: TorrentsSettingsPagePresenter.self),
			comment: "Incomplete file names extension description")
	}

	public static var seedingHeader: String {
		NSLocalizedString(
			"SEEDING_HEADER",
			tableName: "TorrentsSettings",
			bundle: Bundle(for: TorrentsSettingsPagePresenter.self),
			comment: "Seeding header description")
	}

	public static var stopSeedingAtRatio: String {
		NSLocalizedString(
			"STOP_SEEDING_AT_RATIO",
			tableName: "TorrentsSettings",
			bundle: Bundle(for: TorrentsSettingsPagePresenter.self),
			comment: "Stop seeding at ratio description")
	}

	public static var mustBeANumber: String {
		NSLocalizedString(
			"MUST_BE_A_NUMBER",
			tableName: "TorrentsSettings",
			bundle: Bundle(for: TorrentsSettingsPagePresenter.self),
			comment: "Must be a number error description")
	}

	public static var mustBeADirectory: String {
		NSLocalizedString(
			"MUST_BE_A_DIRECTORY",
			tableName: "TorrentsSettings",
			bundle: Bundle(for: TorrentsSettingsPagePresenter.self),
			comment: "Must be a directory error description")
	}

	public static var stopSeedingIfIdle: String {
		NSLocalizedString(
			"STOP_SEEDING_IF_IDLE",
			tableName: "TorrentsSettings",
			bundle: Bundle(for: TorrentsSettingsPagePresenter.self),
			comment: "Stop seeding if idle description")
	}

	public static var confirmButtonTitle: String {
		NSLocalizedString(
			"CONFIRM_BUTTON_TITLE",
			tableName: "TorrentsSettings",
			bundle: Bundle(for: TorrentsSettingsPagePresenter.self),
			comment: "Confirm button title")
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
			isLoading: false,
			seedRatioLimitError: false,
			idleSeedingLimitError: false,
			downloadDirError: false
		)
	}
}
