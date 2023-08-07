//
//  UserDefaultsHandler.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 28/07/23.
//

import Foundation

// MARK: - UserDefaultsKeys

enum UserDefaultsKeys: String {
	case updateInterval
}

// MARK: - UserDefaultsHandler

class UserDefaultsHandler {
	// MARK: Lifecycle
	
	private init() {
		if let value = UserDefaults.standard.value(forKey: UserDefaultsKeys.updateInterval.rawValue) as? Int {
			updateInterval = value
		} else {
			updateInterval = 5
		}
	}
	
	// MARK: Internal
	
	static let shared = UserDefaultsHandler()
	
	var updateInterval: Int {
		didSet {
			setUpdateInterval(updateInterval)
		}
	}
	
	private func setUpdateInterval(_ updateInterval: Int) {
		UserDefaults.standard.setValue(updateInterval, forKey: UserDefaultsKeys.updateInterval.rawValue)
	}
}
