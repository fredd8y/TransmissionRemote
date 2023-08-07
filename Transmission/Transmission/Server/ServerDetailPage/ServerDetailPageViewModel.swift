//
//  ServerDetailPageViewModel.swift
//  Transmission
//
//  Created by Federico Arvat on 30/07/23.
//

import Foundation

public typealias ServerDetailPageError = ServerDetailPageViewModel.ServerDetailPageError

public class ServerDetailPageViewModel: ObservableObject {
	
	public enum ServerDetailPageError: Error {
		case name
		case ip
		case port
		case username
		case password
	}
	
	public init(
		title: String,
		name: String? = nil,
		httpProtocol: HTTPProtocol? = nil,
		ip: String? = nil,
		port: String? = nil,
		username: String? = nil,
		password: String? = nil,
		error: ServerDetailPageError? = nil,
		serverId: UUID
	) {
		self.title = title
		self.name = name
		self.httpProtocol = httpProtocol
		self.ip = ip
		self.port = port
		self.username = username
		self.password = password
		self.error = error
		self.serverId = serverId
	}
	
	public var title: String
	public var name: String?
	public var httpProtocol: HTTPProtocol?
	public var ip: String?
	public var port: String?
	public var username: String?
	public var password: String?
	@Published public var error: ServerDetailPageError?
	public var serverId: UUID
}
