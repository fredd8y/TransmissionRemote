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
	
	public static var alertErrorTitle: String {
		NSLocalizedString(
			"ALERT_ERROR_TITLE",
			tableName: "Torrents",
			bundle: Bundle(for: TorrentsPagePresenter.self),
			comment: "Title for torrents page alert error")
	}
	
	public static var missingServerError: String {
		NSLocalizedString(
			"MISSING_SERVER_ERROR",
			tableName: "Torrents",
			bundle: Bundle(for: TorrentsPagePresenter.self),
			comment: "Error to show when server is missing")
	}
	
	public static var filePermissionError: String {
		NSLocalizedString(
			"FILE_PERMISSION_ERRROR",
			tableName: "Torrents",
			bundle: Bundle(for: TorrentsPagePresenter.self),
			comment: "Error to show when file is not usable")
	}
	
	public static var itemAlreadyAdded: String {
		NSLocalizedString(
			"ITEM_ALREADY_ADDED_ERROR",
			tableName: "Torrents",
			bundle: Bundle(for: TorrentsPagePresenter.self),
			comment: "Error to show when selected item is already added")
	}
	
	public static var genericError: String {
		NSLocalizedString(
			"GENERIC_ERROR",
			tableName: "Torrents",
			bundle: Bundle(for: TorrentsPagePresenter.self),
			comment: "Error to show when the cause is unknown")
	}
	
	public static func map(
		title: String,
		error: String?,
		uploadSpeed: Int,
		downloadSpeed: Int,
		torrents: [Torrent],
		emptyMessage: String?,
		alertMessage: String?,
		alertMessageVisible: Bool
	) -> TorrentsPageViewModel {
		return TorrentsPageViewModel(
			title: title,
			error: error,
			uploadSpeed: uploadSpeed.speed,
			downloadSpeed: downloadSpeed.speed,
			torrents: torrents.map {
				TorrentPresenter.map($0)
			},
			emptyMessage: emptyMessage,
			alertMessage: alertMessage,
			alertMessageVisible: alertMessageVisible
		)
	}
}
