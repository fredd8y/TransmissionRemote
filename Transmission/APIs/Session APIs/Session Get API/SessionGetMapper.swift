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
	
	public enum Error: Swift.Error {
		case invalidData
		case missingSessionId(sessionIdValue: Any?)
	}
	
	public static func map(_ data: Data, from response: HTTPURLResponse) throws -> Session {
		guard response.isOK, let remoteSessionItem = try? JSONDecoder().decode(RemoteSession.self, from: data) else {
			if response.isMissingSessionId {
				throw Error.missingSessionId(sessionIdValue: response.allHeaderFields[sessionIdKey])
			}
			throw Error.invalidData
		}
		return remoteSessionItem.sessionItem
	}
	
}
