//
//  SettingsPageViewModel.swift
//  Transmission
//
//  Created by Federico Arvat on 27/07/23.
//

import SwiftUI

public class SettingsPageViewModel: ObservableObject {
	public init(
		title: String,
		pollingRateTitle: String,
		pollingRateList: [String],
		currentSelectedPollingRate: String,
		serversTitle: String,
		currentServerName: String
	) {
		self.title = title
		self.pollingRateTitle = pollingRateTitle
		self.pollingRateList = pollingRateList
		self.currentSelectedPollingRate = currentSelectedPollingRate
		self.serversTitle = serversTitle
		self.currentServerName = currentServerName
	}
		
	@Published public var title: String
	@Published public var pollingRateTitle: String
	@Published public var pollingRateList: [String]
	@Published public var currentSelectedPollingRate: String
	@Published public var serversTitle: String
	@Published public var currentServerName: String
}
