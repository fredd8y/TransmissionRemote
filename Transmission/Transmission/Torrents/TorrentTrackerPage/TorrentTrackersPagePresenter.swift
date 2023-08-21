//
//  TorrentTrackersPagePresenter.swift
//  Transmission
//
//  Created by Federico Arvat on 21/08/23.
//

import Foundation

public class TorrentTrackersPagePresenter {
	
	public static var title: String {
		NSLocalizedString(
			"TITLE",
			tableName: "TorrentTrackers",
			bundle: Bundle(for: TorrentTrackersPagePresenter.self),
			comment: "Page title")
	}
	
}
