//
//  Server+Utils.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 22/08/23.
//

import Foundation
import Transmission

extension Server {
	var baseURL: URL {
		return URL(string: url)!
	}
	
	var credentials: (username: String, password: String)? {
		if let username, let password {
			let decryptedPassword = try! Cipher.decryptPassword(
				password,
				withKey: try! Cipher.generateSymmetricKey(withPassword: try! Keychain.getPasswordKey())
			)
			return (username, decryptedPassword)
		} else {
			return nil
		}
	}
}
