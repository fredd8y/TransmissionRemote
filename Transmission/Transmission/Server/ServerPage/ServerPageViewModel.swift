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
		editItemActionTitle: String,
		deleteItemActionTitle: String,
		currentSelectedServerId: UUID?,
		emptyMessage: String?,
		alertMessage: String?,
		alertMessageVisible: Bool
	) {
		self.title = title
		self.servers = servers
		self.editItemActionTitle = editItemActionTitle
		self.deleteItemActionTitle = deleteItemActionTitle
		self.currentSelectedServerId = currentSelectedServerId
		self.emptyMessage = emptyMessage
		self.alertMessage = alertMessage
		self.alertMessageVisible = alertMessageVisible
	}
	
	@Published public var title: String
	@Published public var servers: [ServerViewModel]
	public var editItemActionTitle: String
	public var deleteItemActionTitle: String
	@Published public var currentSelectedServerId: UUID?
	@Published public var emptyMessage: String?
	@Published public var alertMessage: String?
	@Published public var alertMessageVisible: Bool
	
	public static func == (lhs: ServerPageViewModel, rhs: ServerPageViewModel) -> Bool {
		lhs.title == rhs.title &&
		lhs.servers == rhs.servers &&
		lhs.editItemActionTitle == rhs.editItemActionTitle &&
		lhs.deleteItemActionTitle == rhs.deleteItemActionTitle &&
		lhs.currentSelectedServerId == rhs.currentSelectedServerId &&
		lhs.emptyMessage == rhs.emptyMessage
	}
	
}
