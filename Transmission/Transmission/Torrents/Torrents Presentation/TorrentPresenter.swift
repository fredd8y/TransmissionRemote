//
//  TorrentPresenter.swift
//  Transmission
//
//  Created by Federico Arvat on 19/07/23.
//

import Foundation

public final class TorrentPresenter {
	public static var of: String {
		NSLocalizedString(
			"TORRENT_ITEM_OF_PREPOSITION",
			tableName: "Torrents",
			bundle: Bundle(for: TorrentsPresenter.self),
			comment: #"Downloaded "of" preposition"#)
	}
	
	public static var downloadCompletedIn: String {
		NSLocalizedString(
			"DOWNLOAD_COMPLETED_IN",
			tableName: "Torrents",
			bundle: Bundle(for: TorrentsPresenter.self),
			comment: "Prefix of relative time to download completion")
	}
	
	public static var completed: String {
		NSLocalizedString(
			"COMPLETED",
			tableName: "Torrents",
			bundle: Bundle(for: TorrentsPresenter.self),
			comment: "Completed word")
	}
	
	public static func map(_ torrent: Torrent) -> TorrentViewModel {

		let relativeDateFormatter = RelativeDateTimeFormatter()
		relativeDateFormatter.locale = .current
		relativeDateFormatter.calendar = .current
		
		return TorrentViewModel(
			name: torrent.name,
			error: torrent.errorString != "" ? torrent.errorString : nil,
			eta: torrent.eta > 0 ? "\(downloadCompletedIn) \(relativeDateFormatter.localizedString(fromTimeInterval: Double(torrent.eta)))" : completed,
			completionPercentage: torrent.percentDone,
			completionPercentageString: ((torrent.percentDone * 100).round() ?? "-") + "%",
			downloaded: "\(Int(Double(torrent.totalSize) * torrent.percentDone).byteSize) \(of) \(torrent.totalSize.byteSize)",
			downloadSpeed: torrent.rateDownload.byteSize
		)
	}
}
