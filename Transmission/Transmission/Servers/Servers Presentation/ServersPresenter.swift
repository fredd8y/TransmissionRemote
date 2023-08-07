//
//  ServersPresenter.swift
//  Transmission
//
//  Created by Federico Arvat on 29/07/23.
//

import Foundation

public final class ServersPresenter {
	public static var title: String {
		NSLocalizedString(
			"SERVERS_VIEW_TITLE",
			tableName: "Servers",
			bundle: Bundle(for: ServersPresenter.self),
			comment: "Title for the servers view")
	}
	
	public static func map(
		title: String,
		servers: [Server],
		currentSelectedServer: Server?
	) -> ServersViewModel {
		return ServersViewModel(
			title: title,
			servers: servers.map(ServerPresenter.map),
			currentSelectedServer: currentSelectedServer?.id
		)
	}
}
