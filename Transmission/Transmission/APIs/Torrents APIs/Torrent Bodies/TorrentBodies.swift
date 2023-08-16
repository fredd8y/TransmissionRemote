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
		struct MissingTorrentSource: Error {}
		struct InvalidTorrentFilePath: Error {}
		
		init(_ startWhenAdded: Bool, _ downloadDir: String, _ torrentFilePath: String?, _ filename: String?) throws {
			guard torrentFilePath != nil || filename != nil else { throw MissingTorrentSource() }
			var metainfo: String?
			if let torrentFilePath {
				guard let url = URL(string: torrentFilePath) else { throw InvalidTorrentFilePath() }
				metainfo = try Data(contentsOf: url).base64EncodedString()
			}
			arguments = Arguments(paused: !startWhenAdded, downloadDir: downloadDir, metainfo: metainfo, filename: filename)
		}
		
		let method: String = "torrent-add"
		let arguments: Arguments
		
		struct Arguments: Encodable {
			let paused: Bool
			let downloadDir: String
			let metainfo: String?
			let filename: String?
			
			enum CodingKeys: String, CodingKey {
				case paused
				case downloadDir = "download-dir"
				case metainfo
				case filename
			}
		}
	}
	
	public static func add(startWhenAdded: Bool, downloadDir: String, torrentFilePath: String?, filename: String?) throws -> Data {
		try JSONEncoder().encode(TorrentAddBody(startWhenAdded, downloadDir, torrentFilePath, filename))
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
	
	public static func remove(id: Int, deleteLocalData: Bool) -> Data {
		try! JSONEncoder().encode(TorrentRemoveBody(id: id, deleteLocalData: deleteLocalData))
	}
}

extension TorrentBodies {
	private struct TorrentStopBody: Encodable {
		init(id: Int) {
			arguments = Arguments(ids: [id])
		}
		
		let method: String = "torrent-stop"
		let arguments: Arguments
		
		struct Arguments: Encodable {
			let ids: [Int]
		}
	}
	
	public static func stop(id: Int) -> Data {
		try! JSONEncoder().encode(TorrentStopBody(id: id))
	}
}

extension TorrentBodies {
	private struct TorrentStartBody: Encodable {
		init(id: Int) {
			arguments = Arguments(ids: [id])
		}
		
		let method: String = "torrent-start"
		let arguments: Arguments
		
		struct Arguments: Encodable {
			let ids: [Int]
		}
	}
	
	public static func start(id: Int) -> Data {
		try! JSONEncoder().encode(TorrentStartBody(id: id))
	}
}

extension TorrentBodies {
	private struct TorrentStartAllBody: Encodable {
		let method: String = "torrent-start"
	}
	
	public static func startAll() -> Data {
		try! JSONEncoder().encode(TorrentStartAllBody())
	}
}
