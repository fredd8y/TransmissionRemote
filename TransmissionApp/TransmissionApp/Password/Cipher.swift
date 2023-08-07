//
//  Cipher.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 05/08/23.
//

import Foundation
import CryptoKit

enum Cipher {
	
	private static let tagLength = 32
	private static let nonceLength = 24
	
	struct DecryptError: Error {}
	struct EncryptionError: Error {}
	struct GenerateSymmetricKeyError: Error {}
	
	static func generateSymmetricKey(withPassword password: String) throws -> SymmetricKey {
		guard let dataPassword = password.data(using: .utf8) else {
			throw GenerateSymmetricKeyError()
		}
		let localKeyHash = SHA256.hash(data: dataPassword)
		return SymmetricKey(data: localKeyHash)
	}
	
	static func encryptPassword(
		_ password: String,
		withKey key: SymmetricKey
	) throws -> String {
		do {
			guard let dataPassword = password.data(using: .utf8) else {
				throw EncryptionError()
			}
			let sealedBox = try AES.GCM.seal(dataPassword, using: key, nonce: nil)
			if let combined = sealedBox.combined {
				return combined.base16EncodedString()
			} else {
				throw EncryptionError()
			}
		} catch {
			throw EncryptionError()
		}
	}
	
	static func decryptPassword(_ password: String, withKey key: SymmetricKey) throws -> String {
		do {
			var item = password
			let nonce = String(item.prefix(nonceLength))
			item.removeFirst(nonceLength)
			let tag = String(item.suffix(tagLength))
			item.removeLast(tagLength)
			let sealedBoxRestored = try AES.GCM.SealedBox(
				nonce: try AES.GCM.Nonce(data: Data(base16Encoded: nonce)),
				ciphertext: Data(base16Encoded: item),
				tag: Data(base16Encoded: tag)
			)
			let data = try AES.GCM.open(sealedBoxRestored, using: key)
			guard let password = String(data: data, encoding: .utf8) else {
				throw DecryptError()
			}
			return password
		} catch {
			throw DecryptError()
		}
	}
}
