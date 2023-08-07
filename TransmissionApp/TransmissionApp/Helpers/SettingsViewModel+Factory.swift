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
			updateIntervalTitle: SettingsPresenter.updateIntervalTitle,
			updateIntervalList: ["-"],
			currentSelectedIntervalIndex: "-",
			serversTitle: SettingsPresenter.serverTitle,
			currentServerName: "-"
		)
	}
}
