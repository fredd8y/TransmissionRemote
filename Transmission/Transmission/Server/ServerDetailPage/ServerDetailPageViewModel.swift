//
//  ServerDetailPageViewModel.swift
//  Transmission
//
//  Created by Federico Arvat on 30/07/23.
//

import Foundation

public class ServerDetailPageViewModel: ObservableObject {
	public init(
		serverSectionHeader: String,
		authenticationSectionHeader: String,
		title: String,
		name: String? = nil,
		namePlaceholder: String,
		httpProtocol: String? = nil,
		protocolPlaceholder: String,
		ip: String? = nil,
		ipPlaceholder: String,
		port: String? = nil,
		portPlaceholder: String,
		username: String? = nil,
		usernamePlaceholder: String,
		password: String? = nil,
		passwordPlaceholder: String
	) {
		self.serverSectionHeader = serverSectionHeader
		self.authenticationSectionHeader = authenticationSectionHeader
		self.title = title
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
	}
	
	@Published public var serverSectionHeader: String
	@Published public var authenticationSectionHeader: String
	@Published public var title: String
	@Published public var name: String?
	@Published public var namePlaceholder: String
	@Published public var httpProtocol: String?
	@Published public var protocolPlaceholder: String
	@Published public var ip: String?
	@Published public var ipPlaceholder: String
	@Published public var port: String?
	@Published public var portPlaceholder: String
	@Published public var username: String?
	@Published public var usernamePlaceholder: String
	@Published public var password: String?
	@Published public var passwordPlaceholder: String
}
