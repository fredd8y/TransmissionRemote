//
//  SettingsViewModel.swift
//  Transmission
//
//  Created by Federico Arvat on 27/07/23.
//

import Foundation

public class SettingsViewModel {
	public init(
		title: String,
		updateIntervalTitle: String,
		updateIntervalList: [String],
		currentSelectedIntervalIndex: Int,
		serversTitle: String,
		currentServerName: String
	) {
		self.title = title
		self.updateIntervalTitle = updateIntervalTitle
		self.updateIntervalList = updateIntervalList
		self.currentSelectedIntervalIndex = currentSelectedIntervalIndex
		self.serversTitle = serversTitle
		self.currentServerName = currentServerName
	}
		
	public let title: String
	public let updateIntervalTitle: String
	public let updateIntervalList: [String]
	public let currentSelectedIntervalIndex: Int
	public let serversTitle: String
	public let currentServerName: String
}
