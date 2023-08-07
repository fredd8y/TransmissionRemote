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
	
	public static var torrents: String {
		NSLocalizedString(
			"TORRENTS",
			tableName: "Torrents",
			bundle: Bundle(for: TorrentsPresenter.self),
			comment: "Plural of torrent")
	}
	
	public static var torrent: String {
		NSLocalizedString(
			"TORRENT",
			tableName: "Torrents",
			bundle: Bundle(for: TorrentsPresenter.self),
			comment: "Singular of torrent")
	}
	
	public static var username: String {
		NSLocalizedString(
			"USERNAME",
			tableName: "Torrents",
			bundle: Bundle(for: TorrentsPresenter.self),
			comment: "Credential alert username placeholer")
	}
	
	public static var password: String {
		NSLocalizedString(
			"PASSWORD",
			tableName: "Torrents",
			bundle: Bundle(for: TorrentsPresenter.self),
			comment: "Credential alert password placeholer")
	}
	
	public static var credentialRequested: String {
		NSLocalizedString(
			"CREDENTIAL_NEEDED_TITLE",
			tableName: "Torrents",
			bundle: Bundle(for: TorrentsPresenter.self),
			comment: "Title when credential are required")
	}
	
	public static var ok: String {
		NSLocalizedString(
			"OK",
			tableName: "Torrents",
			bundle: Bundle(for: TorrentsPresenter.self),
			comment: "Ok string")
	}
	
	public static var undefinedError: String {
		NSLocalizedString(
			"UNDEFINED_ERROR",
			tableName: "Torrents",
			bundle: Bundle(for: TorrentsPresenter.self),
			comment: "Generic error for invalidData")
	}
	
	public static func map(
		title: String,
		error: String?,
		uploadSpeed: Int,
		downloadSpeed: Int,
		torrents: [Torrent]
	) -> TorrentsViewModel {
		let stringUploadSpeed = (Double(uploadSpeed) / 1_000_000).round() ?? "0,00"
		let stringDownloadSpeed = (Double(downloadSpeed) / 1_000_000).round() ?? "0,00"
		return TorrentsViewModel(
			title: title,
			error: error,
			uploadSpeed: "\(stringUploadSpeed) MB/s",
			downloadSpeed: "\(stringDownloadSpeed) MB/s",
			torrents: torrents.map {
				TorrentPresenter.map($0)
			}
		)
	}
}
