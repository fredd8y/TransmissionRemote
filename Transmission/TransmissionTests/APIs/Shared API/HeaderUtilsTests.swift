//
//  HeaderUtilsTests.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 22/07/23.
//

import XCTest
import Transmission

final class HeaderUtilsTests: XCTestCase {
	func test_basicAuthCredentialsString_createCorrectBasicAuthCredential() {
		let username = "a username"
		let password = "a password"
		let authorizationString = "\(username):\(password)".data(using: .utf8)!.base64EncodedString()
		
		XCTAssertEqual(HeaderUtils.basicAuthCredentialsString(username: username, password: password), "Basic \(authorizationString)")
	}
	
	func test_AUTHORIZATION_KEY() {
		XCTAssertEqual(HeaderUtils.AUTHORIZATION_KEY, "Authorization")
	}
}
