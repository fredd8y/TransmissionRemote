//
//  ServerPagePresenter.swift
//  Transmission
//
//  Created by Federico Arvat on 29/07/23.
//

import Foundation

public final class ServerPagePresenter {
	public static var title: String {
		NSLocalizedString(
			"SERVERS_VIEW_TITLE",
			tableName: "Servers",
			bundle: Bundle(for: ServerPagePresenter.self),
			comment: "Title for the servers view")
	}
	
	public static func map(
		title: String,
		servers: [Server],
		currentSelectedServer: Server?
	) -> ServerPageViewModel {
		return ServerPageViewModel(
			title: title,
			servers: servers.map(ServerPresenter.map),
			currentSelectedServer: currentSelectedServer?.id
		)
	}
}
