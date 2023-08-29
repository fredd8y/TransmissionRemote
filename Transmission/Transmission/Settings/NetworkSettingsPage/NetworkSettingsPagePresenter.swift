//
//  NetworkSettingsPagePresenter.swift
//  Transmission
//
//  Created by Federico Arvat on 29/08/23.
//

import Foundation

public class NetworkSettingsPagePresenter {
	public static var title: String {
		NSLocalizedString(
			"NETWORK_SETTINGS_PAGE_TITLE",
			tableName: "NetworkSettings",
			bundle: Bundle(for: NetworkSettingsPagePresenter.self),
			comment: "Network settings page title")
	}
}
