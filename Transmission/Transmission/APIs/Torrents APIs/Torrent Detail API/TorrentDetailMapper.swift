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
	}
	
	public static func map(_ data: Data, from response: HTTPURLResponse) throws -> TorrentDetail {
		guard response.isOK, let remoteTorrentDetail = try? JSONDecoder().decode(RemoteTorrentDetail.self, from: data) else {
			throw Error.invalidData
		}
		if remoteTorrentDetail.arguments.torrents.count <= 0 || remoteTorrentDetail.arguments.torrents.count > 1 {
			throw Error.invalidData
		}
		return remoteTorrentDetail.torrentDetail
	}
	
	private struct RemoteTorrentDetail: Decodable {
		let arguments: Arguments
		let result: String
		
		struct Arguments: Decodable {
			let torrents: [Torrent]
			
			struct Torrent: Decodable {
				let name: String
				let downloadDir: String
				let error: Int
				let errorString: String
				let eta: Int
				let id: Int
				let hashString: String
				let uploadRatio: Double
				let uploadedEver: Int
				let percentDone: Double
				let rateDownload: Int
				let rateUpload: Int
				let totalSize: Int
				let isPrivate: Bool
				let status: Int
				let activityDate: Int
				let corruptEver: Int
				let desiredAvailable: Int
				let downloadedEver: Int
				let fileStats: [FileStat]
				let haveUnchecked: Int
				let haveValid: Int
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
					let progress: Double
					let rateToClient: Int
					let rateToPeer: Int
				}
				
				struct TrackerStat: Decodable {
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
		
		var torrentDetail: TorrentDetail {
			let torrent = arguments.torrents.first!
			return TorrentDetail(
				name: torrent.name,
				percentageAvailability: torrent.percentDone,
				uploaded: torrent.uploadedEver,
				ratio: torrent.uploadRatio,
				downloaded: torrent.downloadedEver,
				state: Status(torrent.status),
				startDate: torrent.startDate,
				eta: torrent.eta,
				lastActivity: torrent.activityDate,
				error: torrent.errorString,
				size: torrent.totalSize,
				location: torrent.downloadDir,
				hash: torrent.hashString,
				isPrivate: torrent.isPrivate
			)
		}
	}
	
}
