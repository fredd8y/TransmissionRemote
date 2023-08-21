//
//  TorrentTracker.swift
//  Transmission
//
//  Created by Federico Arvat on 21/08/23.
//

import Foundation

public struct TorrentTracker: Equatable {
	public init(
		id: Int,
		host: String,
		lastAnnounceTime: Int,
		lastAnnouncePeerCount: Int,
		nextAnnounceTime: Int,
		lastScrapeTime: Int,
		seederCount: Int,
		leecherCount: Int,
		downloadCount: Int
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
	
	let id: Int
	let host: String
	let lastAnnounceTime: Int
	let lastAnnouncePeerCount: Int
	let nextAnnounceTime: Int
	let lastScrapeTime: Int
	let seederCount: Int
	let leecherCount: Int
	let downloadCount: Int
}
