//
//  TorrentPeersPagePresenter.swift
//  Transmission
//
//  Created by Federico Arvat on 20/08/23.
//

import Foundation

public class TorrentPeersPagePresenter {
	
	public static var title: String {
		NSLocalizedString(
			"TITLE",
			tableName: "TorrentPeers",
			bundle: Bundle(for: TorrentDetailPresenter.self),
			comment: "Page title")
	}
	
}
