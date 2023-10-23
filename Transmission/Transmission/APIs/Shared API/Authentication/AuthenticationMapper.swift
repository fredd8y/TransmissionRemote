//
//  AuthenticationMapper.swift
//  Transmission
//
//  Created by Federico Arvat on 23/10/23.
//

import Foundation

public final class AuthenticationMapper {
	public static func map(_ data: Data, from response: HTTPURLResponse) throws -> (Data, HTTPURLResponse) {
		if response.isMissingSessionId {
			throw AuthenticationError.missingSessionId(sessionIdValue: response.allHeaderFields[AuthenticationConstants.sessionIdKey] as? String)
		}
		if response.isAuthenticationFailed {
			throw AuthenticationError.authenticationFailed
		}
		return (data, response)
	}
}
