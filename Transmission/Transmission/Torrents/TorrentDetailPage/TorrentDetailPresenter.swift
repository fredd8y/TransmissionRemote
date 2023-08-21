//
//  TorrentDetailPresenter.swift
//  Transmission
//
//  Created by Federico Arvat on 17/08/23.
//

import Foundation

public class TorrentDetailPresenter {
	
	public static var title: String {
		NSLocalizedString(
			"TITLE",
			tableName: "TorrentDetail",
			bundle: Bundle(for: TorrentDetailPresenter.self),
			comment: "Page title")
	}
	
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
	
	public static var name: String {
		NSLocalizedString(
			"NAME",
			tableName: "TorrentDetail",
			bundle: Bundle(for: TorrentDetailPresenter.self),
			comment: "Name field description")
	}
	
	public static var percentageCompleted: String {
		NSLocalizedString(
			"AVAILABILITY",
			tableName: "TorrentDetail",
			bundle: Bundle(for: TorrentDetailPresenter.self),
			comment: "Percentage completed field description")
	}
	
	public static var uploaded: String {
		NSLocalizedString(
			"UPLOADED",
			tableName: "TorrentDetail",
			bundle: Bundle(for: TorrentDetailPresenter.self),
			comment: "Uploaded field description")
	}
	
	public static var downloaded: String {
		NSLocalizedString(
			"DOWNLOADED",
			tableName: "TorrentDetail",
			bundle: Bundle(for: TorrentDetailPresenter.self),
			comment: "Downloaded field description")
	}
	
	public static var state: String {
		NSLocalizedString(
			"STATE",
			tableName: "TorrentDetail",
			bundle: Bundle(for: TorrentDetailPresenter.self),
			comment: "State field description")
	}
	
	public static var runningTime: String {
		NSLocalizedString(
			"RUNNING_TIME",
			tableName: "TorrentDetail",
			bundle: Bundle(for: TorrentDetailPresenter.self),
			comment: "Running time field description")
	}
	
	public static var remainingTime: String {
		NSLocalizedString(
			"REMAINING_TIME",
			tableName: "TorrentDetail",
			bundle: Bundle(for: TorrentDetailPresenter.self),
			comment: "Remaining time field description")
	}
	
	public static var lastActivity: String {
		NSLocalizedString(
			"LAST_ACTIVITY",
			tableName: "TorrentDetail",
			bundle: Bundle(for: TorrentDetailPresenter.self),
			comment: "Last activity field description")
	}
	
	public static var error: String {
		NSLocalizedString(
			"ERROR",
			tableName: "TorrentDetail",
			bundle: Bundle(for: TorrentDetailPresenter.self),
			comment: "Error field description")
	}
	
	public static var size: String {
		NSLocalizedString(
			"SIZE",
			tableName: "TorrentDetail",
			bundle: Bundle(for: TorrentDetailPresenter.self),
			comment: "Size field description")
	}
	
	public static var location: String {
		NSLocalizedString(
			"LOCATION",
			tableName: "TorrentDetail",
			bundle: Bundle(for: TorrentDetailPresenter.self),
			comment: "Location field description")
	}
	
	public static var hash: String {
		NSLocalizedString(
			"HASH",
			tableName: "TorrentDetail",
			bundle: Bundle(for: TorrentDetailPresenter.self),
			comment: "Hash field description")
	}
	
	public static var privacy: String {
		NSLocalizedString(
			"PRIVACY",
			tableName: "TorrentDetail",
			bundle: Bundle(for: TorrentDetailPresenter.self),
			comment: "Privacy field description")
	}
	
	public static var activitySectionHeader: String {
		NSLocalizedString(
			"ACTIVITY_SECTION_HEADER",
			tableName: "TorrentDetail",
			bundle: Bundle(for: TorrentDetailPresenter.self),
			comment: "Activity section header title")
	}
	
	public static var detailsSectionHeader: String {
		NSLocalizedString(
			"DETAILS_SECTION_HEADER",
			tableName: "TorrentDetail",
			bundle: Bundle(for: TorrentDetailPresenter.self),
			comment: "Details section header title")
	}
	
	public static var completed: String {
		NSLocalizedString(
			"COMPLETED",
			tableName: "TorrentDetail",
			bundle: Bundle(for: TorrentDetailPresenter.self),
			comment: "Completed description")
	}
	
	public static var none: String {
		NSLocalizedString(
			"NONE",
			tableName: "TorrentDetail",
			bundle: Bundle(for: TorrentDetailPresenter.self),
			comment: "None description")
	}
	
	public static func map(_ torrentDetail: TorrentDetail, referenceDate: Date = Date(), decimalSeparator: String? = nil) -> TorrentDetailPageViewModel {
		return TorrentDetailPageViewModel(
			name: torrentDetail.name,
			percentageCompleted: ((torrentDetail.percentageAvailability * 100).round(decimalSeparator: decimalSeparator) ?? "-") + "%",
			uploaded: torrentDetail.uploaded.byteSize,
			ratio: torrentDetail.ratio.round() ?? "-",
			downloaded: torrentDetail.downloaded.byteSize,
			state: torrentDetail.state.value,
			runningTime: relativeEta(torrentDetail.startDate - Int(referenceDate.timeIntervalSince1970)),
			remainingTime: torrentDetail.eta > 0 ? relativeEta(torrentDetail.eta) : completed,
			lastActivity: relativeEta(torrentDetail.lastActivity - Int(referenceDate.timeIntervalSince1970)),
			error: torrentDetail.error.isEmpty ? none : torrentDetail.error,
			size: torrentDetail.size.byteSize,
			location: torrentDetail.location,
			hash: torrentDetail.hash,
			privacy: torrentDetail.isPrivate ? privateTorrent : publicTorrent
		)
	}
	
	private static func relativeEta(_ value: Int) -> String {
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
