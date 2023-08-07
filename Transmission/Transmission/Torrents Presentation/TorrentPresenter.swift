//
//  TorrentPresenter.swift
//  Transmission
//
//  Created by Federico Arvat on 19/07/23.
//

import Foundation

public final class TorrentPresenter {
	public static var eta: String {
		NSLocalizedString(
			"TORRENT_ITEM_ETA",
			tableName: "Torrents",
			bundle: Bundle(for: TorrentsPresenter.self),
			comment: "Torrent ETA")
	}
	
	public static var of: String {
		NSLocalizedString(
			"TORRENT_ITEM_OF_PREPOSITION",
			tableName: "Torrents",
			bundle: Bundle(for: TorrentsPresenter.self),
			comment: #"Downloaded "of" preposition"#)
	}
	
	public static func map(_ torrent: Torrent) -> TorrentViewModel {
		let percentDone = torrent.percentDone * 100
		return TorrentViewModel(
			name: torrent.name,
			error: torrent.errorString != "" ? torrent.errorString : nil,
			eta: torrent.eta > 0 ? "\(eta) \(torrent.eta.description)" : "Completed",
			completionPercentage: percentDone,
			completionPercentageString: (percentDone.round() ?? "-") + "%",
			downloaded: "\((torrent.totalSize * Int(torrent.percentDone)).byteSize) \(of) \(torrent.totalSize.byteSize)",
			downloadSpeed: torrent.rateDownload.byteSize
		)
	}
}
