//
//  ServerDetailPageViewModel+Factory.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 31/07/23.
//

import Foundation
import Transmission

extension ServerDetailPageViewModel {
	init(server: Server) {
		self.init(
			serverSectionHeader: ServerDetailPagePresenter.serverSectionHeader,
			authenticationSectionHeader: ServerDetailPagePresenter.authenticationSectionHeader,
			title: ServerDetailPagePresenter.title,
			saveButtonTitle: ServerDetailPagePresenter.saveButtonTitle,
			name: server.name,
			namePlaceholder: ServerDetailPagePresenter.namePlaceholder,
			httpProtocol: server.httpProtocol,
			protocolPlaceholder: ServerDetailPagePresenter.protocolPlaceholder,
			ip: server.ip,
			ipPlaceholder: ServerDetailPagePresenter.ipPlaceholder,
			port: server.port.description,
			portPlaceholder: ServerDetailPagePresenter.portPlaceholder,
			username: server.username,
			usernamePlaceholder: ServerDetailPagePresenter.usernamePlaceholder,
			password: server.password,
			passwordPlaceholder: ServerDetailPagePresenter.passwordPlaceholder,
			serverId: server.id
		)
	}
	
	init(
		name: String?,
		httpProtocol: HTTPProtocol?,
		ip: String?,
		port: String?,
		username: String?,
		password: String?,
		serverId: UUID
	) {
		self.init(
			serverSectionHeader: ServerDetailPagePresenter.serverSectionHeader,
			authenticationSectionHeader: ServerDetailPagePresenter.authenticationSectionHeader,
			title: ServerDetailPagePresenter.title,
			saveButtonTitle: ServerDetailPagePresenter.saveButtonTitle,
			name: name,
			namePlaceholder: ServerDetailPagePresenter.namePlaceholder,
			httpProtocol: httpProtocol,
			protocolPlaceholder: ServerDetailPagePresenter.protocolPlaceholder,
			ip: ip,
			ipPlaceholder: ServerDetailPagePresenter.ipPlaceholder,
			port: port,
			portPlaceholder: ServerDetailPagePresenter.portPlaceholder,
			username: username,
			usernamePlaceholder: ServerDetailPagePresenter.usernamePlaceholder,
			password: password,
			passwordPlaceholder: ServerDetailPagePresenter.passwordPlaceholder,
			serverId: serverId
		)
	}
	
	init() {
		self.init(
			serverSectionHeader: ServerDetailPagePresenter.serverSectionHeader,
			authenticationSectionHeader: ServerDetailPagePresenter.authenticationSectionHeader,
			title: ServerDetailPagePresenter.title,
			saveButtonTitle: ServerDetailPagePresenter.saveButtonTitle,
			name: "",
			namePlaceholder: ServerDetailPagePresenter.namePlaceholder,
			httpProtocol: .http,
			protocolPlaceholder: ServerDetailPagePresenter.protocolPlaceholder,
			ip: "",
			ipPlaceholder: ServerDetailPagePresenter.ipPlaceholder,
			port: "",
			portPlaceholder: ServerDetailPagePresenter.portPlaceholder,
			username: "",
			usernamePlaceholder: ServerDetailPagePresenter.usernamePlaceholder,
			password: "",
			passwordPlaceholder: ServerDetailPagePresenter.passwordPlaceholder,
			serverId: UUID()
		)
	}
}
