//
//  ServersViewModel.swift
//  Transmission
//
//  Created by Federico Arvat on 29/07/23.
//

import Foundation

public class ServersViewModel: ObservableObject {
	public init(
		title: String,
		servers: [ServerViewModel],
		currentSelectedServer: UUID
	) {
		self.title = title
		self.servers = servers
		self.currentSelectedServer = currentSelectedServer
	}
	
	@Published public var title: String
	@Published public var servers: [ServerViewModel]
	public var currentSelectedServer: UUID
}
