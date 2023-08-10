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
	
	public static var editItemActionTitle: String {
		NSLocalizedString(
			"SERVER_PAGE_ITEM_EDIT_ACTION",
			tableName: "Servers",
			bundle: Bundle(for: ServerPagePresenter.self),
			comment: "Title for server edit action")
	}
	
	public static var deleteItemActionTitle: String {
		NSLocalizedString(
			"SERVER_PAGE_ITEM_DELETE_ACTION",
			tableName: "Servers",
			bundle: Bundle(for: ServerPagePresenter.self),
			comment: "Title for server delete action")
	}
	
	public static var serverPageEmptyMessage: String {
		NSLocalizedString(
			"SERVER_PAGE_EMPTY_MESSAGE",
			tableName: "Servers",
			bundle: Bundle(for: ServerPagePresenter.self),
			comment: "Message to show when there is no server")
	}
	
	public static func map(
		title: String,
		servers: [Server],
		currentSelectedServer: Server?
	) -> ServerPageViewModel {
		return ServerPageViewModel(
			title: title,
			servers: servers.map(ServerPresenter.map),
			editItemActionTitle: editItemActionTitle,
			deleteItemActionTitle: deleteItemActionTitle,
			currentSelectedServerId: currentSelectedServer?.id,
			emptyMessage: servers.count > 0 ? nil : ServerPagePresenter.serverPageEmptyMessage
		)
	}
}
