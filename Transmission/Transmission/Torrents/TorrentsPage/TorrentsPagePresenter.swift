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
	
    public static var serverTimeout: String {
        NSLocalizedString(
            "SERVER_TIMEOUT",
            tableName: "Torrents",
            bundle: Bundle(for: TorrentsPagePresenter.self),
            comment: "Title when server time out")
    }
    
	public static var connectionUnavailable: String {
		NSLocalizedString(
			"CONNECTION_UNAVAILABLE",
			tableName: "Torrents",
			bundle: Bundle(for: TorrentsPagePresenter.self),
			comment: "Title when server time out")
	}
	
	public static var serverUnreachable: String {
		NSLocalizedString(
			"SERVER_UNREACHABLE",
			tableName: "Torrents",
			bundle: Bundle(for: TorrentsPagePresenter.self),
			comment: "Title when server is unreachable")
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
	
	public static var deleteTorrentAlertTitle: String {
		NSLocalizedString(
			"DELETE_TORRENT_ALERT_TITLE",
			tableName: "Torrents",
			bundle: Bundle(for: TorrentsPagePresenter.self),
			comment: "Title for delete torrent alert")
	}
	
	public static var deleteTorrentAlertMessage: String {
		NSLocalizedString(
			"DELETE_TORRENT_ALERT_MESSAGE",
			tableName: "Torrents",
			bundle: Bundle(for: TorrentsPagePresenter.self),
			comment: "Message for delete torrent alert")
	}
	
	public static var deleteAllTorrentAlertMessage: String {
		NSLocalizedString(
			"DELETE_ALL_TORRENT_ALERT_MESSAGE",
			tableName: "Torrents",
			bundle: Bundle(for: TorrentsPagePresenter.self),
			comment: "Message for delete all torrent alert")
	}
	
	public static var deleteLocalData: String {
		NSLocalizedString(
			"DELETE_LOCAL_DATA",
			tableName: "Torrents",
			bundle: Bundle(for: TorrentsPagePresenter.self),
			comment: "Title for delete local data button")
	}
	
	public static var keepLocalData: String {
		NSLocalizedString(
			"KEEP_LOCAL_DATA",
			tableName: "Torrents",
			bundle: Bundle(for: TorrentsPagePresenter.self),
			comment: "Title keep local data button")
	}
	
	public static var cancel: String {
		NSLocalizedString(
			"CANCEL",
			tableName: "Torrents",
			bundle: Bundle(for: TorrentsPagePresenter.self),
			comment: "Title for cancel button")
	}
	
	public static var remove: String {
		NSLocalizedString(
			"REMOVE",
			tableName: "Torrents",
			bundle: Bundle(for: TorrentsPagePresenter.self),
			comment: "Title for remove button")
	}
	
	public static var stop: String {
		NSLocalizedString(
			"STOP",
			tableName: "Torrents",
			bundle: Bundle(for: TorrentsPagePresenter.self),
			comment: "Title for stop button")
	}
	
	public static var start: String {
		NSLocalizedString(
			"START",
			tableName: "Torrents",
			bundle: Bundle(for: TorrentsPagePresenter.self),
			comment: "Title for start button")
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
	
	public static var linkTitle: String {
		NSLocalizedString(
			"LINK_TITLE",
			tableName: "Torrents",
			bundle: Bundle(for: TorrentsPagePresenter.self),
			comment: "Title to be shown on link alert popup")
	}
	
	public static var link: String {
		NSLocalizedString(
			"LINK",
			tableName: "Torrents",
			bundle: Bundle(for: TorrentsPagePresenter.self),
			comment: "Link word")
	}
	
	public static var linkPlaceholder: String {
		NSLocalizedString(
			"LINK_PLACEHOLDER",
			tableName: "Torrents",
			bundle: Bundle(for: TorrentsPagePresenter.self),
			comment: "Placeholder to be shown on link alert popup")
	}
	
	public static var linkInsertDescription: String {
		NSLocalizedString(
			"LINK_INSERT_DESCRIPTION",
			tableName: "Torrents",
			bundle: Bundle(for: TorrentsPagePresenter.self),
			comment: "Description to be shown on link alert popup")
	}
	
	public static var freeSpace: String {
		NSLocalizedString(
			"FREE_SPACE",
			tableName: "Torrents",
			bundle: Bundle(for: TorrentsPagePresenter.self),
			comment: "Description of free space to be shown in torrents page")
	}
	
	public static var emptyTorrentListMessage: String {
		NSLocalizedString(
			"EMPTY_TORRENT_LIST_MESSAGE",
			tableName: "Torrents",
			bundle: Bundle(for: TorrentsPagePresenter.self),
			comment: "Message to show when torrent list is empty")
	}
	
	public static var lockTo: String {
		NSLocalizedString(
			"LOCK_TO",
			tableName: "Torrents",
			bundle: Bundle(for: TorrentsPagePresenter.self),
			comment: "Lock to")
	}
	
	public static var up: String {
		NSLocalizedString(
			"UP",
			tableName: "Torrents",
			bundle: Bundle(for: TorrentsPagePresenter.self),
			comment: "Up")
	}
	
	public static var down: String {
		NSLocalizedString(
			"DOWN",
			tableName: "Torrents",
			bundle: Bundle(for: TorrentsPagePresenter.self),
			comment: "Down")
	}
	
	public static var unlockSpeedLimit: String {
		NSLocalizedString(
			"UNLOCK_SPEED_LIMIT",
			tableName: "Torrents",
			bundle: Bundle(for: TorrentsPagePresenter.self),
			comment: "Button description to unlock speed limit")
	}
	
	public static var stopAll: String {
		NSLocalizedString(
			"STOP_ALL",
			tableName: "Torrents",
			bundle: Bundle(for: TorrentsPagePresenter.self),
			comment: "Button description to stop all torrent")
	}
	
	public static var startAll: String {
		NSLocalizedString(
			"START_ALL",
			tableName: "Torrents",
			bundle: Bundle(for: TorrentsPagePresenter.self),
			comment: "Button description to start all torrent")
	}
	
	public static var removeAll: String {
		NSLocalizedString(
			"REMOVE_ALL",
			tableName: "Torrents",
			bundle: Bundle(for: TorrentsPagePresenter.self),
			comment: "Button description to remove all torrent")
	}
	
	public static var closeTorrentDetail: String {
		NSLocalizedString(
			"CLOSE_TORRENT_DETAIL",
			tableName: "Torrents",
			bundle: Bundle(for: TorrentsPagePresenter.self),
			comment: "Button description to close torrent detail")
	}
	
	public static func map(
		title: String,
		isLoading: Bool,
		error: String?,
		uploadSpeed: Int,
		downloadSpeed: Int,
		temporaryUploadSpeed: Int,
		temporaryDownloadSpeed: Int,
		temporarySpeedEnabled: Bool,
		torrents: [Torrent],
		freeDiskSpace: Int?,
		emptyMessage: String?,
		canAddTorrent: Bool,
		alertMessage: String?,
		alertMessageVisible: Bool,
		decimalSeparator: String? = nil
	) -> TorrentsPageViewModel {
		return TorrentsPageViewModel(
			title: title,
			isLoading: isLoading,
			error: error,
			uploadSpeed: uploadSpeed.speed(decimalSeparator: decimalSeparator),
			downloadSpeed: downloadSpeed.speed(decimalSeparator: decimalSeparator),
			temporaryUploadSpeed: temporaryUploadSpeed.kilobyteSpeed(decimalSeparator: decimalSeparator),
			temporaryDownloadSpeed: temporaryDownloadSpeed.kilobyteSpeed(decimalSeparator: decimalSeparator),
			temporarySpeedEnabled: temporarySpeedEnabled,
			torrents: torrents.map {
				TorrentPresenter.map($0)
			},
			freeDiskSpace: "\(TorrentsPagePresenter.freeSpace) \(freeDiskSpace?.byteSize(decimalSeparator: decimalSeparator) ?? "-")",
			emptyMessage: emptyMessage,
			canAddTorrent: canAddTorrent,
			alertMessage: alertMessage,
			alertMessageVisible: alertMessageVisible
		)
	}
}
