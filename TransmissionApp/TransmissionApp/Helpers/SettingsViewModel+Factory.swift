//
//  SettingsPageViewModel+Factory.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 28/07/23.
//

import Transmission

extension SettingsPageViewModel {
	static func empty() -> SettingsPageViewModel {
		SettingsPageViewModel(
			title: SettingsPagePresenter.title,
			pollingRateTitle: SettingsPagePresenter.pollingRateTitle,
			pollingRateList: ["-"],
			currentSelectedPollingRate: "-",
			serversTitle: SettingsPagePresenter.serverTitle,
			currentServerName: "-"
		)
	}
}
