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
	
	public static func map(json: Data, from response: HTTPURLResponse) throws {
		guard response.isOK, let _ = try? JSONDecoder().decode(RemoteStats.self, from: json) else {
			throw Error.invalidData
		}
	}
}
