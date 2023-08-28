//
//  PeersSettingsPagePresenter.swift
//  Transmission
//
//  Created by Federico Arvat on 28/08/23.
//

import Foundation

public class PeersSettingsPagePresenter {
	
	public static var title: String {
		NSLocalizedString(
			"PEERS_SETTINGS_PAGE_TITLE",
			tableName: "PeersSettings",
			bundle: Bundle(for: TorrentsSettingsPagePresenter.self),
			comment: "Torrents settings page title")
	}
	
}
