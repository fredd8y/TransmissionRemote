//
//  Headers.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 22/08/23.
//

import Foundation
import Transmission

enum Headers {
	
	static func headers(_ credentials: (username: String, password: String)?) -> [String: String] {
		var headers: [String: String] = [:]
		if let credentials {
			headers[HeaderUtils.AUTHORIZATION_KEY] = HeaderUtils.basicAuthCredentialsString(username: credentials.username, password: credentials.password)
		}
		if let sessionId = TransmissionHTTPClient.sessionId {
			headers[AuthenticationConstants.sessionIdKey] = sessionId
		}
		return headers
	}
	
}
