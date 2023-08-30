//
//  TorrentTrackersPagePresenter.swift
//  Transmission
//
//  Created by Federico Arvat on 21/08/23.
//

import Foundation

public class TorrentTrackersPagePresenter {
	
	public static var title: String {
		NSLocalizedString(
			"TITLE",
			tableName: "TorrentTrackers",
			bundle: Bundle(for: TorrentTrackersPagePresenter.self),
			comment: "Page title")
	}
	
	public static var lastAnnounce: String {
		NSLocalizedString(
			"LAST_ANNOUNCE",
			tableName: "TorrentTrackers",
			bundle: Bundle(for: TorrentTrackersPagePresenter.self),
			comment: "Last announce description")
	}
	
	public static var nextAnnounce: String {
		NSLocalizedString(
			"NEXT_ANNOUNCE",
			tableName: "TorrentTrackers",
			bundle: Bundle(for: TorrentTrackersPagePresenter.self),
			comment: "Next announce description")
	}
	
	public static var lastScrape: String {
		NSLocalizedString(
			"LAST_SCRAPE",
			tableName: "TorrentTrackers",
			bundle: Bundle(for: TorrentTrackersPagePresenter.self),
			comment: "Last scrape description")
	}
	
	public static var seeders: String {
		NSLocalizedString(
			"SEEDERS",
			tableName: "TorrentTrackers",
			bundle: Bundle(for: TorrentTrackersPagePresenter.self),
			comment: "Seeders description")
	}
	
	public static var leechers: String {
		NSLocalizedString(
			"LEECHERS",
			tableName: "TorrentTrackers",
			bundle: Bundle(for: TorrentTrackersPagePresenter.self),
			comment: "Leechers description")
	}
	
	public static var downloads: String {
		NSLocalizedString(
			"DOWNLOADS",
			tableName: "TorrentTrackers",
			bundle: Bundle(for: TorrentTrackersPagePresenter.self),
			comment: "Downloads description")
	}
	
	public static func map(_ torrentTrackers: [TorrentTracker], referenceDate: Date = Date()) -> TorrentTrackersPageViewModel {
		TorrentTrackersPageViewModel(
			trackers: torrentTrackers.map { tracker in
				TorrentTrackersPageViewModel.Tracker(
					id: tracker.id,
					host: tracker.host,
					lastAnnounceTime: relativeEta(tracker.lastAnnounceTime - Int(referenceDate.timeIntervalSince1970)),
					lastAnnouncePeerCount: relativeEta(tracker.lastAnnouncePeerCount - Int(referenceDate.timeIntervalSince1970)),
					nextAnnounceTime: relativeEta(tracker.nextAnnounceTime - Int(referenceDate.timeIntervalSince1970)),
					lastScrapeTime: relativeEta(tracker.lastScrapeTime - Int(referenceDate.timeIntervalSince1970)),
					seederCount: tracker.seederCount.description,
					leecherCount: tracker.leecherCount.description,
					downloadCount: tracker.downloadCount.description
				)
			},
			errorMessage: nil
		)
	}
	
	static func relativeEta(_ value: Int, locale: Locale = .current, calendar: Calendar = .current) -> String {
		let relativeDateFormatter = RelativeDateTimeFormatter()
		relativeDateFormatter.locale = locale
		relativeDateFormatter.calendar = calendar
		
		return relativeDateFormatter.localizedString(fromTimeInterval: Double(value))
	}
}
