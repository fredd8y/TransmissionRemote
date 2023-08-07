//
//  SharedServer.swift
//  Transmission
//
//  Created by Federico Arvat on 30/07/23.
//

import Foundation

extension Server.HTTPProtocol {
	var rawValue: String {
		switch self {
		case .http: return "http"
		case .https: return "https"
		}
	}
}
