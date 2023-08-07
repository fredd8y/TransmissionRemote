//
//  CipherTests.swift
//  TransmissionAppTests
//
//  Created by Federico Arvat on 05/08/23.
//

import XCTest
@testable import TransmissionApp

final class CipherTests: XCTestCase {
	
	func test_generateSymmetricKey_doesNotThrow() {
		XCTAssertNoThrow(try Cipher.generateSymmetricKey(withPassword: anyPassword))
	}
	
	func test_encryptPassword_doesNotThrow() {
		XCTAssertNoThrow(
			try Cipher.encryptPassword(
				anyPassword,
				withKey: try Cipher.generateSymmetricKey(withPassword: anyPassword)
			)
		)
	}
	
	func test_decryptPassword_isEqualToEncryptedPassword() {
		let expectedPassword = anyPassword
		let cryptedPassword = try! Cipher.encryptPassword(
			expectedPassword,
			withKey: try! Cipher.generateSymmetricKey(withPassword: anyPassword)
		)
		do {
			let password = try Cipher.decryptPassword(cryptedPassword, withKey: try! Cipher.generateSymmetricKey(withPassword: anyPassword))
			XCTAssertEqual(expectedPassword, password)
		} catch {
			XCTFail("Error, something went wrong while decrypting password")
		}
	}
	
	// MARK: - Helpers
	
	var anyPassword: String {
		"any password"
	}
	
}
