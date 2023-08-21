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
			}
		)
	}
	
	private static func relativeEta(_ value: Int) -> String {
		let relativeDateFormatter = RelativeDateTimeFormatter()
		relativeDateFormatter.locale = .current
		relativeDateFormatter.calendar = .current
		
		return relativeDateFormatter.localizedString(fromTimeInterval: Double(value))
	}
}
