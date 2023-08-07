//
//  TabContainerPresenter.swift
//  Transmission
//
//  Created by Federico Arvat on 04/08/23.
//

import Foundation

public final class TabContainerPresenter {
	
	public static var torrent: String {
		NSLocalizedString(
			"TORRENT",
			tableName: "TabContainer",
			bundle: Bundle(for: TorrentsPagePresenter.self),
			comment: "Torrent tab title")
	}
	
	public static var settings: String {
		NSLocalizedString(
			"SETTINGS",
			tableName: "TabContainer",
			bundle: Bundle(for: TorrentsPagePresenter.self),
			comment: "Settings tab title")
	}
	
}
