//
//  TorrentsPresenter.swift
//  Transmission
//
//  Created by Federico Arvat on 18/07/23.
//

import Foundation

public final class TorrentsPresenter {
	public static var title: String {
		NSLocalizedString(
			"TORRENTS_VIEW_TITLE",
			tableName: "Torrents",
			bundle: Bundle(for: TorrentsPresenter.self),
			comment: "Title for the torrents view")
	}
	
	private static var eta: String {
		NSLocalizedString(
			"TORRENT_ITEM_ETA",
			tableName: "Torrents",
			bundle: Bundle(for: TorrentsPresenter.self),
			comment: "Torrent ETA")
	}
	
	private static var of: String {
		NSLocalizedString(
			"TORRENT_ITEM_OF_PREPOSITION",
			tableName: "Torrents",
			bundle: Bundle(for: TorrentsPresenter.self),
			comment: #"Downloaded "of" preposition"#)
	}
	
	public static func map(_ torrent: Torrent) -> TorrentViewModel {
		TorrentViewModel(
			name: torrent.name,
			error: torrent.errorString != "" ? torrent.errorString : nil,
			eta: "\(eta) \(torrent.eta.description)",
			completionPercentage: torrent.percentDone,
			completionPercentageString: torrent.percentDone.description,
			downloaded: "\((torrent.totalSize * Int(torrent.percentDone)).description) \(of) \(torrent.totalSize.description)",
			downloadSpeed: torrent.rateDownload.description
		)
	}
}
