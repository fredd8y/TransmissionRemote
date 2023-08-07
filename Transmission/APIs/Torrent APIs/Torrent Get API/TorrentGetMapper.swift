//
//  TorrentGetMapper.swift
//  Transmission
//
//  Created by Federico Arvat on 16/05/23.
//

import Foundation

public final class TorrentGetMapper {
	
	public enum Error: Swift.Error {
		case invalidData
	}
	
	public static func map(_ data: Data, from response: HTTPURLResponse) throws -> [Torrent] {
		guard response.isOK, let remoteTorrents = try? JSONDecoder().decode(RemoteTorrents.self, from: data) else {
			throw Error.invalidData
		}
		return remoteTorrents.torrents
	}
	
	private struct RemoteTorrents: Decodable {
		private let arguments: Arguments
		private let result: String
		
		private struct Arguments: Decodable {
			let torrents: [RemoteTorrent]
			
			struct RemoteTorrent: Decodable {
				let error: Int
				let errorString: String
				let eta: Int
				let id: Int
				let isFinished: Bool
				let percentDone: Double
				let rateDownload: Int
			}
		}
		
		var torrents: [Torrent] {
			arguments.torrents.map {
				Torrent(
					error: $0.error,
					errorString: $0.errorString,
					eta: $0.eta,
					id: $0.id,
					isFinished: $0.isFinished,
					percentDone: $0.percentDone,
					rateDownload: $0.rateDownload
				)
			}
		}
	}
	
}
