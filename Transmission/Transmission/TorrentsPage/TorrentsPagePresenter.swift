//
//  TorrentsPagePresenter.swift
//  Transmission
//
//  Created by Federico Arvat on 18/07/23.
//

import Foundation

public final class TorrentsPagePresenter {
	public static var title: String {
		NSLocalizedString(
			"TORRENTS_VIEW_TITLE",
			tableName: "Torrents",
			bundle: Bundle(for: TorrentsPagePresenter.self),
			comment: "Title for the torrents view")
	}
	
	public static var torrents: String {
		NSLocalizedString(
			"TORRENTS",
			tableName: "Torrents",
			bundle: Bundle(for: TorrentsPagePresenter.self),
			comment: "Plural of torrent")
	}
	
	public static var torrent: String {
		NSLocalizedString(
			"TORRENT",
			tableName: "Torrents",
			bundle: Bundle(for: TorrentsPagePresenter.self),
			comment: "Singular of torrent")
	}
	
	public static var credentialRequired: String {
		NSLocalizedString(
			"CREDENTIAL_NEEDED_TITLE",
			tableName: "Torrents",
			bundle: Bundle(for: TorrentsPagePresenter.self),
			comment: "Title when credential are required")
	}
	
	public static var ok: String {
		NSLocalizedString(
			"OK",
			tableName: "Torrents",
			bundle: Bundle(for: TorrentsPagePresenter.self),
			comment: "Ok string")
	}
	
	public static var undefinedError: String {
		NSLocalizedString(
			"UNDEFINED_ERROR",
			tableName: "Torrents",
			bundle: Bundle(for: TorrentsPagePresenter.self),
			comment: "Generic error for invalidData")
	}
	
	public static var serverNotSet: String {
		NSLocalizedString(
			"SERVER_NOT_SET",
			tableName: "Torrents",
			bundle: Bundle(for: TorrentsPagePresenter.self),
			comment: "Error shown when there's no current server set")
	}
	
	public static func map(
		title: String,
		error: String?,
		uploadSpeed: Int,
		downloadSpeed: Int,
		torrents: [Torrent],
		emptyMessage: String?
	) -> TorrentsPageViewModel {
		return TorrentsPageViewModel(
			title: title,
			error: error,
			uploadSpeed: uploadSpeed.speed,
			downloadSpeed: downloadSpeed.speed,
			torrents: torrents.map {
				TorrentPresenter.map($0)
			},
			emptyMessage: emptyMessage
		)
	}
}
