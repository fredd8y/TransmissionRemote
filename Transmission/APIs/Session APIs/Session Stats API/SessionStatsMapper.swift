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
	
	public static func map(from response: HTTPURLResponse) throws {
		guard response.isOK else {
			throw Error.invalidData
		}
	}
}
