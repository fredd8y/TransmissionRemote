//
//  ServerDetailPageViewModel.swift
//  Transmission
//
//  Created by Federico Arvat on 30/07/23.
//

import Foundation

public struct ServerDetailPageViewModel {
	public init(
		serverSectionHeader: String,
		authenticationSectionHeader: String,
		title: String,
		saveButtonTitle: String,
		name: String? = nil,
		namePlaceholder: String,
		httpProtocol: HTTPProtocol? = nil,
		protocolPlaceholder: String,
		ip: String? = nil,
		ipPlaceholder: String,
		port: String? = nil,
		portPlaceholder: String,
		username: String? = nil,
		usernamePlaceholder: String,
		password: String? = nil,
		passwordPlaceholder: String,
		serverId: UUID
	) {
		self.serverSectionHeader = serverSectionHeader
		self.authenticationSectionHeader = authenticationSectionHeader
		self.title = title
		self.saveButtonTitle = saveButtonTitle
		self.name = name
		self.protocolPlaceholder = protocolPlaceholder
		self.namePlaceholder = namePlaceholder
		self.httpProtocol = httpProtocol
		self.ip = ip
		self.ipPlaceholder = ipPlaceholder
		self.port = port
		self.portPlaceholder = portPlaceholder
		self.username = username
		self.usernamePlaceholder = usernamePlaceholder
		self.password = password
		self.passwordPlaceholder = passwordPlaceholder
		self.serverId = serverId
	}
	
	public var serverSectionHeader: String
	public var authenticationSectionHeader: String
	public var title: String
	public var saveButtonTitle: String
	public var name: String?
	public var namePlaceholder: String
	public var httpProtocol: HTTPProtocol?
	public var protocolPlaceholder: String
	public var ip: String?
	public var ipPlaceholder: String
	public var port: String?
	public var portPlaceholder: String
	public var username: String?
	public var usernamePlaceholder: String
	public var password: String?
	public var passwordPlaceholder: String
	public var serverId: UUID
}
