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
	
	public static func map(
		title: String,
		server: Server
	) -> ServerDetailPageViewModel {
		ServerDetailPageViewModel(
			title: title,
			name: server.name,
			protocol: server.httpProtocol.rawValue,
			ip: server.ip,
			port: server.port,
			username: server.username,
			password: server.password
		)
	}
}
