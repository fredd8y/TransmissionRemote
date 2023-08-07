//
//  SessionGetMapper.swift
//  Transmission
//
//  Created by Federico Arvat on 13/05/23.
//

import Foundation

public final class SessionGetMapper {
	
	public static var sessionIdKey: String {
		return "X-Transmission-Session-Id"
	}
	
	struct RemoteSessionItem: Decodable {
		
	}
	
	public enum Error: Swift.Error {
		case invalidData
		case missingSessionId(sessionIdValue: Any?)
	}
	
	public static func map(_ data: Data, from response: HTTPURLResponse) throws {
		guard response.isOK else {
			if response.isMissingSessionId {
				throw Error.missingSessionId(sessionIdValue: response.allHeaderFields[sessionIdKey])
			}
			throw Error.invalidData
		}
	}
	
}
