//
//  TorrentDetailPresenter.swift
//  Transmission
//
//  Created by Federico Arvat on 17/08/23.
//

import Foundation

public class TorrentDetailPresenter {
	
	public static var downloadCompletedIn: String {
		NSLocalizedString(
			"DOWNLOAD_COMPLETED_IN",
			tableName: "TorrentDetail",
			bundle: Bundle(for: TorrentDetailPresenter.self),
			comment: "Prefix of relative time to download completion")
	}
	
	public static var privateTorrent: String {
		NSLocalizedString(
			"PRIVATE_TORRENT",
			tableName: "TorrentDetail",
			bundle: Bundle(for: TorrentDetailPresenter.self),
			comment: "Private torrent description")
	}
	
	public static var publicTorrent: String {
		NSLocalizedString(
			"PUBLIC_TORRENT",
			tableName: "TorrentDetail",
			bundle: Bundle(for: TorrentDetailPresenter.self),
			comment: "Public torrent description")
	}
	
	public static var stopped: String {
		NSLocalizedString(
			"STOPPED",
			tableName: "TorrentDetail",
			bundle: Bundle(for: TorrentDetailPresenter.self),
			comment: "Stopped torrent description")
	}
	
	public static var queuedVerifyLocalData: String {
		NSLocalizedString(
			"QUEUED_VERIFY_LOCAL_DATA",
			tableName: "TorrentDetail",
			bundle: Bundle(for: TorrentDetailPresenter.self),
			comment: "Queued to verify local data torrent description")
	}
	
	public static var verifyingLocalData: String {
		NSLocalizedString(
			"VERIFYING_LOCAL_DATA",
			tableName: "TorrentDetail",
			bundle: Bundle(for: TorrentDetailPresenter.self),
			comment: "Verifying local data torrent description")
	}
	
	public static var queuedDownload: String {
		NSLocalizedString(
			"QUEUED_DOWNLOAD",
			tableName: "TorrentDetail",
			bundle: Bundle(for: TorrentDetailPresenter.self),
			comment: "Queued for download torrent description")
	}
	
	public static var downloading: String {
		NSLocalizedString(
			"DOWNLOADING",
			tableName: "TorrentDetail",
			bundle: Bundle(for: TorrentDetailPresenter.self),
			comment: "Downloading torrent description")
	}
	
	public static var queuedToSeed: String {
		NSLocalizedString(
			"QUEUED_TO_SEED",
			tableName: "TorrentDetail",
			bundle: Bundle(for: TorrentDetailPresenter.self),
			comment: "Queued to seed torrent description")
	}
	
	public static var seeding: String {
		NSLocalizedString(
			"SEEDING",
			tableName: "TorrentDetail",
			bundle: Bundle(for: TorrentDetailPresenter.self),
			comment: "Seeding torrent description")
	}
	
	public static var unknown: String {
		NSLocalizedString(
			"UNKNOWN",
			tableName: "TorrentDetail",
			bundle: Bundle(for: TorrentDetailPresenter.self),
			comment: "Unknown torrent description")
	}
	
	public static func map(_ torrentDetail: TorrentDetail) -> TorrentDetailViewModel {
		return TorrentDetailViewModel(
			name: torrentDetail.name,
			percentageCompleted: ((torrentDetail.percentageAvailability * 100).round() ?? "-") + "%",
			uploaded: torrentDetail.uploaded.byteSize,
			ratio: torrentDetail.ratio.round() ?? "-",
			downloaded: torrentDetail.downloaded.byteSize,
			state: torrentDetail.state.value,
			runningTime: relativeEta(torrentDetail.startDate),
			remainingTime: "\(downloadCompletedIn) \(relativeEta(torrentDetail.eta))",
			lastActivity: relativeEta(torrentDetail.lastActivity),
			error: torrentDetail.error,
			size: torrentDetail.size.byteSize,
			location: torrentDetail.location,
			hash: torrentDetail.hash,
			privacy: torrentDetail.isPrivate ? privateTorrent : publicTorrent
		)
	}
	
	private static func relativeEta(_ value: Int) -> String {
		guard value > 0 else { return "ERROR" }
		let relativeDateFormatter = RelativeDateTimeFormatter()
		relativeDateFormatter.locale = .current
		relativeDateFormatter.calendar = .current

		return relativeDateFormatter.localizedString(fromTimeInterval: Double(value))
	}
	
}

private extension Status {
	var value: String {
		switch self {
		case .stopped:
			return TorrentDetailPresenter.stopped
		case .queuedVerifyLocalData:
			return TorrentDetailPresenter.queuedVerifyLocalData
		case .verifyingLocalData:
			return TorrentDetailPresenter.verifyingLocalData
		case .queuedDownload:
			return TorrentDetailPresenter.queuedDownload
		case .downloading:
			return TorrentDetailPresenter.downloading
		case .queuedToSeed:
			return TorrentDetailPresenter.queuedToSeed
		case .seeding:
			return TorrentDetailPresenter.seeding
		case .unknown:
			return TorrentDetailPresenter.unknown
		}
	}
}
