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
				let errorString: String
				let eta: Int
				let hashString: String
				let uploadRatio: Double
				let uploadedEver: Int
				let percentDone: Double
				let totalSize: Int
				let isPrivate: Bool
				let status: Int
				let activityDate: Int
				let downloadedEver: Int
				let startDate: Int
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
