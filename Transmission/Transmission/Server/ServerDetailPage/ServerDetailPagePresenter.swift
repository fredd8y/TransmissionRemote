//
//  ServerDetailPagePresenter.swift
//  Transmission
//
//  Created by Federico Arvat on 30/07/23.
//

import Foundation

public final class ServerDetailPagePresenter {
	
	public static var title: String {
		NSLocalizedString(
			"SERVERS_DETAIL_VIEW_TITLE",
			tableName: "ServerDetails",
			bundle: Bundle(for: ServerDetailPagePresenter.self),
			comment: "Title for the server detail view")
	}
	
	public static var serverSectionHeader: String {
		NSLocalizedString(
			"SERVER_SECTION_HEADER",
			tableName: "ServerDetails",
			bundle: Bundle(for: ServerDetailPagePresenter.self),
			comment: "Title for server properties list")
	}
	
	public static var authenticationSectionHeader: String {
		NSLocalizedString(
			"AUTHENTICATION_SECTION_HEADER",
			tableName: "ServerDetails",
			bundle: Bundle(for: ServerDetailPagePresenter.self),
			comment: "Title for authentication fields")
	}
	
	public static var namePlaceholder: String {
		NSLocalizedString(
			"NAME_PLACEHOLDER",
			tableName: "ServerDetails",
			bundle: Bundle(for: ServerDetailPagePresenter.self),
			comment: "Placeholder for name field")
	}
	
	public static var protocolPlaceholder: String {
		NSLocalizedString(
			"PROTOCOL_PLACEHOLDER",
			tableName: "ServerDetails",
			bundle: Bundle(for: ServerDetailPagePresenter.self),
			comment: "Placeholder for protocol field")
	}
	
	public static var ipPlaceholder: String {
		NSLocalizedString(
			"IP_PLACEHOLDER",
			tableName: "ServerDetails",
			bundle: Bundle(for: ServerDetailPagePresenter.self),
			comment: "Placeholder for ip field")
	}
	
	public static var portPlaceholder: String {
		NSLocalizedString(
			"PORT_PLACEHOLDER",
			tableName: "ServerDetails",
			bundle: Bundle(for: ServerDetailPagePresenter.self),
			comment: "Placeholder for port field")
	}
	
	public static var usernamePlaceholder: String {
		NSLocalizedString(
			"USERNAME_PLACEHOLDER",
			tableName: "ServerDetails",
			bundle: Bundle(for: ServerDetailPagePresenter.self),
			comment: "Placeholder for username field")
	}
	
	public static var passwordPlaceholder: String {
		NSLocalizedString(
			"PASSWORD_PLACEHOLDER",
			tableName: "ServerDetails",
			bundle: Bundle(for: ServerDetailPagePresenter.self),
			comment: "Placeholder for password field")
	}
	
	public static var saveButtonTitle: String {
		NSLocalizedString(
			"SAVE_BUTTON_TITLE",
			tableName: "ServerDetails",
			bundle: Bundle(for: ServerDetailPagePresenter.self),
			comment: "Save button title")
	}
	
	public static func map(
		title: String,
		server: Server
	) -> ServerDetailPageViewModel {
		ServerDetailPageViewModel(
			serverSectionHeader: serverSectionHeader,
			authenticationSectionHeader: authenticationSectionHeader,
			title: title,
			saveButtonTitle: saveButtonTitle,
			name: server.name,
			namePlaceholder: namePlaceholder,
			httpProtocol: server.httpProtocol.rawValue,
			protocolPlaceholder: protocolPlaceholder,
			ip: server.ip,
			ipPlaceholder: ipPlaceholder,
			port: server.port.description,
			portPlaceholder: portPlaceholder,
			username: server.username,
			usernamePlaceholder: usernamePlaceholder,
			password: server.password,
			passwordPlaceholder: passwordPlaceholder
		)
	}
}
