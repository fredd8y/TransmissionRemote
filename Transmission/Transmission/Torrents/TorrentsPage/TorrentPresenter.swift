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
			bundle: Bundle(for: TorrentsPagePresenter.self),
			comment: #"Downloaded "of" preposition"#)
	}
	
	public static var downloadCompletedIn: String {
		NSLocalizedString(
			"DOWNLOAD_COMPLETED_IN",
			tableName: "Torrents",
			bundle: Bundle(for: TorrentsPagePresenter.self),
			comment: "Prefix of relative time to download completion")
	}
	
	public static var stopped: String {
		NSLocalizedString(
			"STOPPED",
			tableName: "Torrents",
			bundle: Bundle(for: TorrentsPagePresenter.self),
			comment: "Stopped word")
	}
	
	public static var verifyingLocalData: String {
		NSLocalizedString(
			"VERIFYING_LOCAL_DATA",
			tableName: "Torrents",
			bundle: Bundle(for: TorrentsPagePresenter.self),
			comment: "Description to show when torrent is verifying local data")
	}
	
	public static var queuedToVerifyLocalData: String {
		NSLocalizedString(
			"QUEUED_TO_VERIFY_LOCAL_DATA",
			tableName: "Torrents",
			bundle: Bundle(for: TorrentsPagePresenter.self),
			comment: "Description to show when torrent is in queue to verify local data")
	}
	
	public static var queuedToDownload: String {
		NSLocalizedString(
			"QUEUED_TO_DOWNLOAD",
			tableName: "Torrents",
			bundle: Bundle(for: TorrentsPagePresenter.self),
			comment: "Description to show when torrent is in queue for download")
	}
	
	public static var queuedToSeed: String {
		NSLocalizedString(
			"QUEUED_TO_SEED",
			tableName: "Torrents",
			bundle: Bundle(for: TorrentsPagePresenter.self),
			comment: "Description to show when torrent is in queue to seed")
	}
	
	public static var seeding: String {
		NSLocalizedString(
			"SEEDING",
			tableName: "Torrents",
			bundle: Bundle(for: TorrentsPagePresenter.self),
			comment: "Description to show when torrent is in queue for seed")
	}
	
	public static var unknown: String {
		NSLocalizedString(
			"UNKNOWN_STATUS",
			tableName: "Torrents",
			bundle: Bundle(for: TorrentsPagePresenter.self),
			comment: "Description to show when torrent is in queue for seed")
	}
	
	public static var unknownDownloadTime: String {
		NSLocalizedString(
			"UNKNOWN_DOWNLOAD_TIME",
			tableName: "Torrents",
			bundle: Bundle(for: TorrentsPagePresenter.self),
			comment: "Description to show when download time is undefined")
	}
	
	static func percentageString(_ value: Double, decimalSeparator: String? = nil) -> String {
		((value * 100).round(decimalSeparator: decimalSeparator) ?? "-") + "%"
	}
	
	static func relativeEta(_ value: Int, locale: Locale = .current, calendar: Calendar = .current) -> String {
		guard value > 0 else { return TorrentPresenter.unknownDownloadTime }
		let relativeDateFormatter = RelativeDateTimeFormatter()
		relativeDateFormatter.locale = locale
		relativeDateFormatter.calendar = calendar
		
		return relativeDateFormatter.localizedString(fromTimeInterval: Double(value))
	}
	
	static func torrentStatusDescription(_ torrent: Torrent) -> String {
		switch torrent.status {
		case .stopped:
			return stopped
		case .queuedVerifyLocalData:
			return queuedToVerifyLocalData
		case .verifyingLocalData:
			return verifyingLocalData
		case .queuedDownload:
			return queuedToDownload
		case .downloading:
			return "\(downloadCompletedIn) \(relativeEta(torrent.eta))"
		case .queuedToSeed:
			return queuedToSeed
		case .seeding:
			return seeding
		case .unknown:
			return unknown
		}
	}
	
	public static func map(_ torrent: Torrent, decimalSeparator: String? = nil) -> TorrentViewModel {
		return TorrentViewModel(
			id: torrent.id,
			name: torrent.name,
			error: torrent.errorString != "" ? torrent.errorString : nil,
			description: torrentStatusDescription(torrent),
			completionPercentage: torrent.percentDone,
			completionPercentageString: percentageString(torrent.percentDone, decimalSeparator: decimalSeparator),
			downloaded: "\(Int(Double(torrent.totalSize) * torrent.percentDone).byteSize(decimalSeparator: decimalSeparator)) \(of) \(torrent.totalSize.byteSize(decimalSeparator: decimalSeparator))",
			uploadSpeed: torrent.rateUpload.speed(decimalSeparator: decimalSeparator),
			downloadSpeed: torrent.rateDownload.speed(decimalSeparator: decimalSeparator),
			status: viewModelStatus(torrent.status)
		)
	}
	
	static func viewModelStatus(_ status: Status) -> TorrentViewModel.Status {
		switch status {
		case .stopped:
			return .stopped
		case .seeding:
			return .completed
		default:
			return .running
		}
	}
}
