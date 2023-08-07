//
//  Server+SharedExtension.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 29/07/23.
//

import Foundation
import Transmission

extension Server.HTTPProtocol {
	var rawValue: String {
		switch self {
		case .http: return "http"
		case .https: return "https"
		}
	}
	
	static func httpProtocol(forValue value: String) -> Self? {
		switch value {
		case "http":
			return .http
		case "https":
			return .https
		default:
			return nil
		}
	}
}
