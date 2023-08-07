//
//  ServerPresenter.swift
//  Transmission
//
//  Created by Federico Arvat on 29/07/23.
//

import Foundation

public class ServerPresenter {
	public static func map(_ server: Server) -> ServerViewModel {
		return ServerViewModel(
			title: server.name,
			url: server.url,
			id: server.id
		)
	}
}
