//
//  TorrentTrackerPageViewModel.swift
//  Transmission
//
//  Created by Federico Arvat on 21/08/23.
//

import Foundation

public class TorrentTrackerPageViewModel: ObservableObject {
	
	public init(trackers: [Tracker]) {
		self.trackers = trackers
	}
	
	@Published public var trackers: [Tracker]
	
	public class Tracker {
		public init(
			id: Int,
			host: String,
			lastAnnounceTime: String,
			lastAnnouncePeerCount: String,
			nextAnnounceTime: String,
			lastScrapeTime: String,
			seederCount: String,
			leecherCount: String,
			downloadCount: String
		) {
			self.id = id
			self.host = host
			self.lastAnnounceTime = lastAnnounceTime
			self.lastAnnouncePeerCount = lastAnnouncePeerCount
			self.nextAnnounceTime = nextAnnounceTime
			self.lastScrapeTime = lastScrapeTime
			self.seederCount = seederCount
			self.leecherCount = leecherCount
			self.downloadCount = downloadCount
		}
		
		public let id: Int
		public let host: String
		public let lastAnnounceTime: String
		public let lastAnnouncePeerCount: String
		public let nextAnnounceTime: String
		public let lastScrapeTime: String
		public let seederCount: String
		public let leecherCount: String
		public let downloadCount: String
	}
	
}
