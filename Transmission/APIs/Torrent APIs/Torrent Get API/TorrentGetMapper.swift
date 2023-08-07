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
	
	public static func map(_ data: Data, from response: HTTPURLResponse) throws {
		guard response.isOK, let _ = try? JSONDecoder().decode(RemoteTorrents.self, from: data) else {
			throw Error.invalidData
		}
	}
	
}
