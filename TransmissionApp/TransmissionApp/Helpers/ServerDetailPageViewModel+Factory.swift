//
//  ServerDetailPageViewModel+Factory.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 31/07/23.
//

import Foundation
import Transmission

extension ServerDetailPageViewModel {
	convenience init(server: Server) {
		self.init(
			title: ServerDetailPagePresenter.title,
			name: server.name,
			httpProtocol: server.httpProtocol,
			ip: server.ip,
			port: server.port.description,
			username: server.username,
			password: server.password,
			serverId: server.id
		)
	}
	
	convenience init(
		name: String?,
		httpProtocol: HTTPProtocol?,
		ip: String?,
		port: String?,
		username: String?,
		password: String?,
		serverId: UUID
	) {
		self.init(
			title: ServerDetailPagePresenter.title,
			name: name,
			httpProtocol: httpProtocol,
			ip: ip,
			port: port,
			username: username,
			password: password,
			serverId: serverId
		)
	}
	
	convenience init() {
		self.init(
			title: ServerDetailPagePresenter.title,
			name: "",
			httpProtocol: .http,
			ip: "",
			port: "",
			username: "",
			password: "",
			serverId: UUID()
		)
	}
}
