//
//  ServerPageViewModel.swift
//  Transmission
//
//  Created by Federico Arvat on 29/07/23.
//

import Foundation

public class ServerPageViewModel: ObservableObject, Equatable {
	
	public init(
		title: String,
		servers: [ServerViewModel],
		currentSelectedServerId: UUID?
	) {
		self.title = title
		self.servers = servers
		self.currentSelectedServerId = currentSelectedServerId
	}
	
	@Published public var title: String
	@Published public var servers: [ServerViewModel]
	public var currentSelectedServerId: UUID?
	
	public static func == (lhs: ServerPageViewModel, rhs: ServerPageViewModel) -> Bool {
		lhs.title == rhs.title && lhs.servers == rhs.servers && lhs.currentSelectedServerId == rhs.currentSelectedServerId
	}
	
}
