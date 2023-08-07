//
//  SessionStatsMapper.swift
//  Transmission
//
//  Created by Federico Arvat on 15/07/23.
//

import Foundation

public final class SessionStatsMapper {
	
	public enum Error: Swift.Error {
		case invalidData
	}
	
	public static func map(_ json: Data, from response: HTTPURLResponse) throws -> Stats {
		guard response.isOK, let remoteStats = try? JSONDecoder().decode(RemoteStats.self, from: json) else {
			throw Error.invalidData
		}
		return remoteStats.stats
	}
	
}
