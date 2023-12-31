//
//  APIsEndpoint.swift
//  Transmission
//
//  Created by Federico Arvat on 13/05/23.
//

import Foundation

public enum APIsEndpoint {
	case post
	
	public func url(baseURL: URL) -> URL {
		switch self {
		case .post:
			var components = URLComponents()
			components.scheme = baseURL.scheme
			components.host = baseURL.host
			components.port = baseURL.port
			components.path = baseURL.path + "/transmission/rpc"
			return components.url!
		}
	}
}
