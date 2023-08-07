//
//  UserDefaultsHandler.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 28/07/23.
//

import Foundation

// MARK: - UserDefaultsKeys

enum UserDefaultsKeys: String {
	case pollingRate
}

// MARK: - UserDefaultsHandler

class UserDefaultsHandler {
	// MARK: Lifecycle
	
	private init() {
		if let value = UserDefaults.standard.value(forKey: UserDefaultsKeys.pollingRate.rawValue) as? Int {
			pollingRate = value
		} else {
			pollingRate = 5
		}
	}
	
	// MARK: Internal
	
	static let shared = UserDefaultsHandler()
	
	@Published var pollingRate: Int {
		didSet {
			setPollingRate(pollingRate)
		}
	}
	
	private func setPollingRate(_ pollingRate: Int) {
		UserDefaults.standard.setValue(pollingRate, forKey: UserDefaultsKeys.pollingRate.rawValue)
	}
}
