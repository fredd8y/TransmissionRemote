//
//  HeaderUtils.swift
//  Transmission
//
//  Created by Federico Arvat on 18/07/23.
//

import Foundation

public enum HeaderUtils {
	/// Key to be used for Basic Authorization Header
	public static let AUTHORIZATION_KEY = "Authorization"
	
	/// Value to append before Basic Authentication credentials
	private static let BASIC_AUTH_KEY = "Basic"
	
	public static func basicAuthCredentialsString(username: String, password: String) -> String {
		let encodedCredentials = "\(username):\(password)".data(using: .utf8)!.base64EncodedString()
		return "\(BASIC_AUTH_KEY) \(encodedCredentials)"
	}
}
