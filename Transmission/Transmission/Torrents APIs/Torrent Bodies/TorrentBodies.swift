//
//  TorrentBodies.swift
//  Transmission
//
//  Created by Federico Arvat on 15/05/23.
//

import Foundation

public enum TorrentBodies {
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
