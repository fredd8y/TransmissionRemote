//
//  TorrentDetailMapper.swift
//  Transmission
//
//  Created by Federico Arvat on 17/08/23.
//

import Foundation

public enum TorrentDetailMapper {
	
	public enum Error: Swift.Error {
		case invalidData
		case failed(explanation: String)
	}
	
	public static func map(_ data: Data, from response: HTTPURLResponse) throws -> TorrentDetail {
		guard response.isOK, let remoteTorrentDetail = try? JSONDecoder().decode(RemoteTorrentDetail.self, from: data) else {
			throw Error.invalidData
		}
		if remoteTorrentDetail.result != SharedAPIsConstants.success {
			throw Error.failed(explanation: remoteTorrentDetail.result)
		}
		return remoteTorrentDetail.torrentDetail
	}
	
	private struct RemoteTorrentDetail: Decodable {
		let arguments: Arguments
		let result: String
		
		struct Arguments: Decodable {
			let activityDate: Int
			let corruptEver: Int
			let desiredAvailable: Int
			let downloadedEver: Int
			let fileStats: [FileStat]
			let haveUnchecked: Int
			let haveValid: Int
			let id: Int
			let peers: [Peer]
			let startDate: Int
			let trackerStats: [TrackerStat]
			
			struct FileStat: Decodable {
				let bytesCompleted: Int
				let priority: Int
				let wanted: Bool
			}
			
			struct Peer: Decodable {
				let address: String
				let clientIsChoked: Bool
				let clientIsInterested: Bool
				let clientName: String
				let flagStr: String
				let isDownloadingFrom: Bool
				let isEncrypted: Bool
				let isIncoming: Bool
				let isUTP: Bool
				let isUploadingTo: Bool
				let peerIsChoked: Bool
				let peerIsInterested: Bool
				let port: Int
				let progress: Int
				let rateToClient: Int
				let rateToPeer: Int
			}
			
			struct TrackerStat: Decodable {
				let announce: String
				let announceState: Int
				let downloadCount: Int
				let hasAnnounced: Bool
				let hasScraped: Bool
				let host: Int
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
		
		var torrentDetail: TorrentDetail {
			TorrentDetail()
		}
	}
	
}
