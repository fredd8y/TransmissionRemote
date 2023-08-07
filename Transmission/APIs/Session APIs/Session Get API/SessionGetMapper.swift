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
	
	public enum Error: Swift.Error, Equatable {
		case invalidData
		case authenticationFailed
		
		public static func == (lhs: SessionGetMapper.Error, rhs: SessionGetMapper.Error) -> Bool {
			switch (lhs, rhs) {
			case (.invalidData, .invalidData):
				return true
			case (.authenticationFailed, .authenticationFailed):
				return true
			default:
				return false
			}
		}
	}
	
	public static func map(_ data: Data, from response: HTTPURLResponse) throws -> Session {
		guard response.isOK, let remoteSessionItem = try? JSONDecoder().decode(RemoteSession.self, from: data) else {
			if response.isAuthenticationFailed {
				throw Error.authenticationFailed
			}
			throw Error.invalidData
		}
		return remoteSessionItem.sessionItem
	}
	
}
