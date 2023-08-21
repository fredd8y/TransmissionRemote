//
//  TorrentTrackersMapper.swift
//  Transmission
//
//  Created by Federico Arvat on 21/08/23.
//

import Foundation

public enum TorrentTrackersMapper {
	
	public enum Error: Swift.Error {
		case invalidData
	}
	
	public static func map(_ data: Data, from response: HTTPURLResponse) throws -> [TorrentTracker] {
		guard response.isOK, let remoteTorrentTrackers = try? JSONDecoder().decode(RemoteTorrentTrackers.self, from: data) else {
			throw Error.invalidData
		}
		if remoteTorrentTrackers.arguments.torrents.count <= 0 || remoteTorrentTrackers.arguments.torrents.count > 1 {
			throw Error.invalidData
		}
		return remoteTorrentTrackers.trackers
	}
	
	private struct RemoteTorrentTrackers: Decodable {
		let arguments: Arguments
		let result: String
		
		struct Arguments: Decodable {
			let torrents: [Torrent]
			
			struct Torrent: Decodable {
				let trackerStats: [Tracker]
				
				struct Tracker: Decodable {
					let announce: String
					let announceState: Int
					let downloadCount: Int
					let hasAnnounced: Bool
					let hasScraped: Bool
					let host: String
					let id: Int
					let isBackup: Bool
					let lastAnnouncePeerCount: Int
					let lastAnnounceResult: String
					let lastAnnounceStartTime: Int
					let lastAnnounceSucceeded: Bool
					let lastAnnounceTime: Int
					let lastAnnounceTimedOut: Bool
					let lastScrapeResult: String
					let lastScrapeStartTime: Int
					let lastScrapeSucceeded: Bool
					let lastScrapeTime: Int
					let lastScrapeTimedOut: Bool
					let leecherCount: Int
					let nextAnnounceTime: Int
					let nextScrapeTime: Int
					let scrape: String
					let scrapeState: Int
					let seederCount: Int
					let tier: Int
				}
			}
		}
		
		var trackers: [TorrentTracker] {
			let torrent = arguments.torrents.first!
			return torrent.trackerStats.map {
				TorrentTracker(
					id: $0.id,
					host: $0.host,
					lastAnnounceTime: $0.lastAnnounceTime,
					lastAnnouncePeerCount: $0.lastAnnouncePeerCount,
					nextAnnounceTime: $0.nextAnnounceTime,
					lastScrapeTime: $0.lastScrapeTime,
					seederCount: $0.seederCount,
					leecherCount: $0.leecherCount,
					downloadCount: $0.downloadCount
				)
			}
		}
	}
	
}
