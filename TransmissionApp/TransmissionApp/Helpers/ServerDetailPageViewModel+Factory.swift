//
//  ServerDetailPageViewModel+Factory.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 31/07/23.
//

import Transmission

extension ServerDetailPageViewModel {
	init(
		name: String?,
		httpProtocol: HTTPProtocol?,
		ip: String?,
		port: String?,
		username: String?,
		password: String?
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
			passwordPlaceholder: ServerDetailPagePresenter.passwordPlaceholder
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
			passwordPlaceholder: ServerDetailPagePresenter.passwordPlaceholder
		)
	}
}
