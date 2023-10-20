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
        switch (error as NSError).code {
        case -1001:
            return SessionGetMapper.Error.serverTimeout
        case -1009:
            return SessionGetMapper.Error.connectionUnavailable
        default:
            return SessionGetMapper.Error.invalidData
        }
	}
	
}
