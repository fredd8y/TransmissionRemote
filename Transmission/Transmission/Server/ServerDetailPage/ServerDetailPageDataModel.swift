//
//  ServerDetailPageDataModel.swift
//  Transmission
//
//  Created by Federico Arvat on 31/07/23.
//

import Foundation

public struct ServerDetailPageDataModel {
	public init(
		name: String,
		httpProtocol: HTTPProtocol,
		ip: String,
		port: String,
		username: String,
		password: String
	) {
		self.name = name
		self.httpProtocol = httpProtocol
		self.ip = ip
		self.port = port
		self.username = username
		self.password = password
	}
	
	
	public enum HTTPProtocol: CaseIterable {
		case http
		case https
	}
	
	public var name: String
	public var httpProtocol: HTTPProtocol
	public var ip: String
	public var port: String
	public var username: String
	public var password: String
	
}
