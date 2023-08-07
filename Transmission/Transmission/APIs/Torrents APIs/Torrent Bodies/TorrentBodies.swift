//
//  TorrentBodies.swift
//  Transmission
//
//  Created by Federico Arvat on 15/05/23.
//

import Foundation



public enum TorrentBodies {}

extension TorrentBodies {
	
	private struct TorrentGetBody: Encodable {
		init(_ fields: [String]) {
			arguments = Arguments(fields: fields)
		}
		
		let method: String = "torrent-get"
		let arguments: Arguments
		
		struct Arguments: Encodable {
			let fields: [String]
		}
	}
	
	public static func get(_ fields: [String]) -> Data {
		try! JSONEncoder().encode(TorrentGetBody(fields))
	}
	
}

extension TorrentBodies {
	
	private struct TorrentAddBody: Encodable {
		struct InvalidTorrentFilePath: Error {}
		
		init(_ startWhenAdded: Bool, _ downloadDir: String, _ torrentFilePath: String) throws {
			guard let url = URL(string: torrentFilePath) else { throw InvalidTorrentFilePath() }
			let torrentBase64 = try Data(contentsOf: url).base64EncodedString()
			arguments = Arguments(paused: !startWhenAdded, downloadDir: downloadDir, metainfo: torrentBase64)
		}
		
		let method: String = "torrent-add"
		let arguments: Arguments
		
		struct Arguments: Encodable {
			let paused: Bool
			let downloadDir: String
			let metainfo: String
			
			enum CodingKeys: String, CodingKey {
				case paused
				case downloadDir = "download-dir"
				case metainfo
			}
		}
	}
	
	public static func add(startWhenAdded: Bool, downloadDir: String, torrentFilePath: String) throws -> Data {
		try JSONEncoder().encode(TorrentAddBody(startWhenAdded, downloadDir, torrentFilePath))
	}
	
}

extension TorrentBodies {
	private struct TorrentRemoveBody: Encodable {
		init(id: Int, deleteLocalData: Bool) {
			arguments = Arguments(ids: [id], deleteLocalData: deleteLocalData)
		}
		
		let method: String = "torrent-remove"
		let arguments: Arguments
		
		struct Arguments: Encodable {
			let ids: [Int]
			let deleteLocalData: Bool
			
			enum CodingKeys: String, CodingKey {
				case ids
				case deleteLocalData = "delete-local-data"
			}
		}
	}
	
	public static func remove(id: Int, deleteLocalData: Bool) throws -> Data {
		try JSONEncoder().encode(TorrentRemoveBody(id: id, deleteLocalData: deleteLocalData))
	}
}
