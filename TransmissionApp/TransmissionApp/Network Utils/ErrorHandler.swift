//
//  ErrorHandler.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 22/08/23.
//

import Foundation
import Transmission

enum ErrorHandler {
	
	static func handleError(_ error: Error) -> Error {
		guard (error as NSError).code == -1001 else {
			return SessionGetMapper.Error.invalidData
		}
		return SessionGetMapper.Error.serverTimeout
	}
	
}
