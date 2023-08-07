//
//  Server.swift
//  Transmission
//
//  Created by Federico Arvat on 27/07/23.
//

import Foundation

public struct Server {
	
	public enum HTTPProtocol {
		case http
		case https
	}
	
	public let name: String
	public let httpProtocol: HTTPProtocol
	public let ip: String
	public let port: Int
	public let username: String?
	public let password: String?
	public let selected: Bool
}
