//
//  Server.swift
//  Transmission
//
//  Created by Federico Arvat on 27/07/23.
//

import Foundation

public struct Server: Equatable {
	public init(
		name: String,
		httpProtocol: HTTPProtocol,
		ip: String,
		port: Int,
		username: String? = nil,
		password: String? = nil,
		id: UUID
	) {
		self.name = name
		self.httpProtocol = httpProtocol
		self.ip = ip
		self.port = port
		self.username = username
		self.password = password
		self.id = id
	}
	
	public let name: String
	public let httpProtocol: HTTPProtocol
	public let ip: String
	public let port: Int
	public let username: String?
	public let password: String?
	public let id: UUID
	
	public var url: String {
		return "\(httpProtocol.rawValue)://\(ip):\(port)"
	}
}
