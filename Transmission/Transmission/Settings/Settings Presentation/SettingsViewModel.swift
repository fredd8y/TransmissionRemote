//
//  SettingsViewModel.swift
//  Transmission
//
//  Created by Federico Arvat on 27/07/23.
//

import SwiftUI

public class SettingsViewModel: ObservableObject {
	public init(
		title: String,
		updateIntervalTitle: String,
		updateIntervalList: [String],
		currentSelectedIntervalIndex: String,
		serversTitle: String,
		currentServerName: String
	) {
		self.title = title
		self.updateIntervalTitle = updateIntervalTitle
		self.updateIntervalList = updateIntervalList
		self.currentSelectedInterval = currentSelectedIntervalIndex
		self.serversTitle = serversTitle
		self.currentServerName = currentServerName
	}
		
	@Published public var title: String
	@Published public var updateIntervalTitle: String
	@Published public var updateIntervalList: [String]
	@Published public var currentSelectedInterval: String
	@Published public var serversTitle: String
	@Published public var currentServerName: String
}
