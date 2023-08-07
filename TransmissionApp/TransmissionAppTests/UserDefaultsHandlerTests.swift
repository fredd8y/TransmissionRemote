//
//  UserDefaultsHandlerTests.swift
//  TransmissionAppTests
//
//  Created by Federico Arvat on 28/07/23.
//

import XCTest
@testable import Transmission
@testable import TransmissionApp

final class UserDefaultsHandlerTests: XCTestCase {
	
	func test_updatePollingRate() {
		let testValue = Int.random(in: 0..<1000)
		
		UserDefaultsHandler.shared.pollingRate = testValue
		
		XCTAssertEqual(testValue, UserDefaultsHandler.shared.pollingRate)
	}

//	func test_setCurrentServerWithAuthentication() {
//		let anyPassword = "any password"
//
//		let testValue = Server(
//			name: "a name",
//			httpProtocol: .https,
//			ip: "192.168.1.1",
//			port: 9091,
//			username: "a username",
//			password: try! Cipher.encryptPassword(
//				anyPassword,
//				withKey: try! Cipher.generateSymmetricKey(withPassword: anyPassword)
//			),
//			id: UUID()
//		)
//
//		UserDefaultsHandler.shared.currentServer = testValue
//
//		XCTAssertEqual(testValue, UserDefaultsHandler.shared.currentServer)
//	}
	
	func test_setCurrentServerWithoutAuthentication() {
		let testValue = Server(
			name: "a name",
			httpProtocol: .https,
			ip: "192.168.1.1",
			port: 9091,
			id: UUID()
		)
		
		UserDefaultsHandler.shared.currentServer = testValue
		
		XCTAssertEqual(testValue, UserDefaultsHandler.shared.currentServer)
	}
	
}
