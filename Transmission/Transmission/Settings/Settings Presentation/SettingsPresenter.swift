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
	
	public static var updateIntervalTitle: String {
		NSLocalizedString(
			"UPDATE_INTERVAL_TITLE",
			tableName: "Settings",
			bundle: Bundle(for: SettingsPresenter.self),
			comment: "Update interval title")
	}
	
	public static var serverTitle: String {
		NSLocalizedString(
			"SERVER_TITLE",
			tableName: "Settings",
			bundle: Bundle(for: SettingsPresenter.self),
			comment: "Server title")
	}
	
	public static var serverNotAvailable: String {
		NSLocalizedString(
			"SERVER_NOT_AVAILABLE",
			tableName: "Settings",
			bundle: Bundle(for: SettingsPresenter.self),
			comment: "Title for server not available ")
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
			currentSelectedIntervalIndex: "\(updateIntervalList[currentSelectedIntervalIndex]) \(seconds)",
			serversTitle: serversTitle,
			currentServerName: currentServerName
		)
	}
}
