//
//  AuthenticationError.swift
//  Transmission
//
//  Created by Federico Arvat on 23/10/23.
//

import Foundation

public enum AuthenticationError: Swift.Error, Equatable {
	case authenticationFailed
	case missingSessionId(sessionIdValue: String?)
	
	public static func == (lhs: AuthenticationError, rhs: AuthenticationError) -> Bool {
		switch (lhs, rhs) {
		case (.authenticationFailed, .authenticationFailed):
			return true
		case (.missingSessionId, .missingSessionId):
			return true
		default:
			return false
		}
	}
}
