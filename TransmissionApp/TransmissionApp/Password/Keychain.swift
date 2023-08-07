//
//  Keychain.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 05/08/23.
//

import Foundation

enum Keychain {
	
	struct AddPasswordFailure: Error {}
	struct GetPasswordFailure: Error {}
	struct GeneratePasswordFailure: Error {}
	
	static let serviceKey: String = "service_key"
	static let accountKey: String = "account_key"
	
	static func generateRandomPassword() throws -> String {
		let lowercaseCharacterSet = "abcdefghijklmnopqrstuvwxyz"
		let uppercaseCharacterSet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
		let numbersCharacterSet = "0123456789"
		let specialCharacterSet = "!#$-_/()?^><+][}{"
		
		var password = ""
		var set = ""
		set.append(lowercaseCharacterSet)
		guard let randomElement = lowercaseCharacterSet.randomElement() else {
			throw GeneratePasswordFailure()
		}
		password.append(String(randomElement))
		set.append(uppercaseCharacterSet)
		guard let randomElement = uppercaseCharacterSet.randomElement() else {
			throw GeneratePasswordFailure()
		}
		password.append(String(randomElement))
		set.append(numbersCharacterSet)
		guard let randomElement = numbersCharacterSet.randomElement() else {
			throw GeneratePasswordFailure()
		}
		password.append(String(randomElement))
		set.append(specialCharacterSet)
		guard let randomElement = specialCharacterSet.randomElement() else {
			throw GeneratePasswordFailure()
		}
		password.append(String(randomElement))
		for _ in 0 ..< 128 - password.count {
			guard let randomElement = set.randomElement() else { break }
			password.append(String(randomElement))
		}
		return String(password.shuffled())
	}
	
	static func addPasswordKey(_ password: String) throws {
		let query: [String: AnyObject] = [
			kSecClass as String: kSecClassGenericPassword,
			kSecAttrService as String: serviceKey as AnyObject,
			kSecAttrAccount as String: accountKey as AnyObject,
			kSecValueData as String: password.data(using: .utf8)! as AnyObject
		]
		let status = SecItemAdd(query as CFDictionary, nil)
		guard status == errSecSuccess else {
			throw AddPasswordFailure()
		}
	}
	
	static func getPasswordKey() throws -> String? {
		let query: [String: Any] = [
			kSecClass as String: kSecClassGenericPassword,
			kSecAttrService as String: Keychain.serviceKey,
			kSecAttrAccount as String: Keychain.accountKey,
			kSecReturnData as String: true
		]
		var item: CFTypeRef?
		let status = SecItemCopyMatching(query as CFDictionary, &item)
		guard status == errSecSuccess else {
			throw GetPasswordFailure()
		}
		guard let _item = item as? Data else {
			throw GetPasswordFailure()
		}
		guard let _stringItem = String(data: _item, encoding: .utf8) else {
			throw GetPasswordFailure()
		}
		return _stringItem
	}
}
