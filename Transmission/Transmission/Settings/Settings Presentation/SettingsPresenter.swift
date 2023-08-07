//
//  SettingsPresenter.swift
//  Transmission
//
//  Created by Federico Arvat on 27/07/23.
//

import Foundation

public class SettingsPresenter {
	public static var title: String {
		NSLocalizedString(
			"SETTINGS_PAGE_TITLE",
			tableName: "Settings",
			bundle: Bundle(for: SettingsPresenter.self),
			comment: "Settings page title")
	}
	
	public static var seconds: String {
		NSLocalizedString(
			"SECONDS",
			tableName: "Settings",
			bundle: Bundle(for: SettingsPresenter.self),
			comment: "Update interval seconds word")
	}
	
	public static func map(
		title: String,
		updateIntervalTitle: String,
		updateIntervalList: [Int],
		currentSelectedIntervalIndex: Int,
		serversTitle: String,
		currentServerName: String
	) -> SettingsViewModel {
		SettingsViewModel(
			title: title,
			updateIntervalTitle: updateIntervalTitle,
			updateIntervalList: updateIntervalList.map { "\($0) \(seconds)" },
			currentSelectedIntervalIndex: currentSelectedIntervalIndex,
			serversTitle: serversTitle,
			currentServerName: currentServerName
		)
	}
}
