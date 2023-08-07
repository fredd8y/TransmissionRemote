//
//  TorrentAddMapper.swift
//  Transmission
//
//  Created by Federico Arvat on 03/08/23.
//

import Foundation

public enum TorrentAddMapper {
	
	public enum Error: Swift.Error {
		case invalidData
		case torrentDuplicate(name: String)
	}
	
	/// Map torrent-add response, throwing error if any, returning added torrent name
	/// - Returns: Added torrent name
	public static func map(_ data: Data, from response: HTTPURLResponse) throws -> String {
		guard response.isOK, let remoteResponse = try? JSONDecoder().decode(RemoteResponse.self, from: data) else {
			throw Error.invalidData
		}
		if let torrentDuplicate = remoteResponse.arguments.torrentDuplicate {
			throw Error.torrentDuplicate(name: torrentDuplicate.name)
		} else if let torrentAdded = remoteResponse.arguments.torrentAdded {
			return torrentAdded.name
		} else {
			throw Error.invalidData
		}
	}
	
	private struct RemoteResponse: Decodable {
		let arguments: Arguments
		let result: String
		
		struct Arguments: Decodable {
			let torrentDuplicate: TorrentDetail?
			let torrentAdded: TorrentDetail?
			
			enum CodingKeys: String, CodingKey {
				case torrentDuplicate = "torrent-duplicate"
				case torrentAdded = "torrent-added"
			}
		}
		
		struct TorrentDetail: Decodable {
			let hashString: String
			let id: Int
			let name: String
		}
	}
}
