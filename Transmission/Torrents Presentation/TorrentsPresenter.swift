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
	
	public static func map(
		title: String,
		uploadSpeed: Int,
		downloadSpeed: Int,
		torrents: [Torrent]
	) -> TorrentsViewModel {
		let stringUploadSpeed = (Double(uploadSpeed) / 1_000_000).round() ?? "0,00"
		let stringDownloadSpeed = (Double(downloadSpeed) / 1_000_000).round() ?? "0,00"
		return TorrentsViewModel(
			title: title,
			uploadSpeed: "\(stringUploadSpeed) MB/s",
			downloadSpeed: "\(stringDownloadSpeed) MB/s",
			torrents: torrents.map {
				TorrentPresenter.map($0)
			}
		)
	}
}
