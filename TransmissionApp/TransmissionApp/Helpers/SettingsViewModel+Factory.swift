//
//  SettingsViewModel+Factory.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 28/07/23.
//

import Transmission

extension SettingsViewModel {
	static func empty() -> SettingsViewModel {
		SettingsViewModel(
			title: SettingsPresenter.title,
			pollingRateTitle: SettingsPresenter.pollingRateTitle,
			pollingRateList: ["-"],
			currentSelectedPollingRate: "-",
			serversTitle: SettingsPresenter.serverTitle,
			currentServerName: "-"
		)
	}
}
