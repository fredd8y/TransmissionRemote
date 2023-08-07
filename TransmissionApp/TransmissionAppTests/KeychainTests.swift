//
//  KeychainTests.swift
//  TransmissionAppTests
//
//  Created by Federico Arvat on 05/08/23.
//

import XCTest
@testable import TransmissionApp

final class KeychainTests: XCTestCase {
	
	override func setUp() {
		SecItemDelete([kSecClass as String: kSecClassGenericPassword] as CFDictionary)
	}
	
	func test_generateRandomPassword_doesNotThrow() {
		XCTAssertNoThrow(try Keychain.generateRandomPassword())
	}
	
	func test_generateRandomPassword_hasLengthEqualTo128() {
		let password = try! Keychain.generateRandomPassword()
		
		XCTAssertEqual(password.count, 128)
	}
	
	func test_addPasswordKey_doesNotThrow() {
		XCTAssertNoThrow(try Keychain.addPasswordKey("test_password"))
	}
	
	func test_addPasswordKey_addPasswordToKeychain() {
		let password = "test_password"
		
		try! Keychain.addPasswordKey(password)
		
		let query: [String: Any] = [
			kSecClass as String: kSecClassGenericPassword,
			kSecAttrService as String: Keychain.serviceKey,
			kSecAttrAccount as String: Keychain.accountKey,
			kSecReturnData as String: true
		]
		var item: CFTypeRef?
		let status = SecItemCopyMatching(query as CFDictionary, &item)
		guard status == errSecSuccess else {
			XCTFail("Error reading password")
			return
		}
		guard let _item = item as? Data else {
			XCTFail("Error in retrieved item")
			return
		}
		guard let _stringItem = String(data: _item, encoding: .utf8) else {
			XCTFail("Error, item is not of type String")
			return
		}
		XCTAssertEqual(_stringItem, password)
	}
	
	func test_getPasswordKey_doesNotThrow() {
		let query: [String: AnyObject] = [
			kSecClass as String: kSecClassGenericPassword,
			kSecAttrService as String: Keychain.serviceKey as AnyObject,
			kSecAttrAccount as String: Keychain.accountKey as AnyObject,
			kSecValueData as String: "test_password".data(using: .utf8)! as AnyObject
		]
		let status = SecItemAdd(query as CFDictionary, nil)
		guard status == errSecSuccess else {
			XCTFail("Error when adding password to keychain")
			return
		}
		
		XCTAssertNoThrow(try Keychain.getPasswordKey())
	}
	
	func test_getPasswordKey_getPasswordFromKeychain() {
		let password = "test_password"
		
		let query: [String: AnyObject] = [
			kSecClass as String: kSecClassGenericPassword,
			kSecAttrService as String: Keychain.serviceKey as AnyObject,
			kSecAttrAccount as String: Keychain.accountKey as AnyObject,
			kSecValueData as String: password.data(using: .utf8)! as AnyObject
		]
		let status = SecItemAdd(query as CFDictionary, nil)
		guard status == errSecSuccess else {
			XCTFail("Error when adding password to keychain")
			return
		}
		
		let retrievedPassword = try! Keychain.getPasswordKey()
		XCTAssertEqual(retrievedPassword, password)
	}
	
}
