//
//  NetworkErrorHandler.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 22/08/23.
//

import Foundation

public enum NetworkError: Error {
    case serverTimeout
    case connectionUnavailable
	case serverUnreachable
    case unknownError
}

public enum NetworkErrorHandler {
	
	public static func handleError(_ error: Error) -> Error {
        switch (error as NSError).code {
        case -1001:
            return NetworkError.serverTimeout
		case -1004:
			return NetworkError.serverUnreachable
        case -1009:
            return NetworkError.connectionUnavailable
        default:
            return NetworkError.unknownError
        }
	}
	
}
