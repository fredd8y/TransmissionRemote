//
//  SettingsPagePresenter.swift
//  Transmission
//
//  Created by Federico Arvat on 27/07/23.
//

import Foundation

public class SettingsPagePresenter {
	public static var title: String {
		NSLocalizedString(
			"SETTINGS_PAGE_TITLE",
			tableName: "Settings",
			bundle: Bundle(for: SettingsPagePresenter.self),
			comment: "Settings page title")
	}
	
	public static var seconds: String {
		NSLocalizedString(
			"SECONDS",
			tableName: "Settings",
			bundle: Bundle(for: SettingsPagePresenter.self),
			comment: "Update interval seconds word")
	}
	
	public static var pollingRateTitle: String {
		NSLocalizedString(
			"POLLING_RATE_TITLE",
			tableName: "Settings",
			bundle: Bundle(for: SettingsPagePresenter.self),
			comment: "Update interval title")
	}
	
	public static var serverTitle: String {
		NSLocalizedString(
			"SERVER_TITLE",
			tableName: "Settings",
			bundle: Bundle(for: SettingsPagePresenter.self),
			comment: "Server title")
	}
	
	public static var serverNotAvailable: String {
		NSLocalizedString(
			"SERVER_NOT_AVAILABLE",
			tableName: "Settings",
			bundle: Bundle(for: SettingsPagePresenter.self),
			comment: "Title for server not available ")
	}
	
	public static func map(
		title: String,
		pollingRateTitle: String,
		pollingRateList: [Int],
		currentSelectedPollingRate: Int,
		serversTitle: String,
		currentServerName: String
	) -> SettingsPageViewModel {
		SettingsPageViewModel(
			title: title,
			pollingRateTitle: pollingRateTitle,
			pollingRateList: pollingRateList.map { secondString($0) },
			currentSelectedPollingRate: secondString(pollingRateList[currentSelectedPollingRate]),
			serversTitle: serversTitle,
			currentServerName: currentServerName
		)
	}
	
	private static func secondString(_ value: Int) -> String {
		"\(value) \(seconds)"
	}
}
