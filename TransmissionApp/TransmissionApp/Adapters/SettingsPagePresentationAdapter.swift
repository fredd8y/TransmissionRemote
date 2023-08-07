//
//  SettingsPagePresentationAdapter.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 27/07/23.
//

import Combine
import Foundation
import Transmission

class SettingsPagePresentationAdapter {
	
	init(settingsViewModel: SettingsViewModel) {
		self.settingsViewModel = settingsViewModel
	}
	
	private var settingsViewModel: SettingsViewModel
	
	private var cancellable: Cancellable?
		
	func loadData() {
		cancellable = Publishers.Zip3(
			ServerPublishers.makeCurrentServerGetLoader(),
			PollingRateHandler.makeUpdatePollingRateLoader(),
			PollingRateHandler.makeCurrentPollingRateLoader()
		)
			.dispatchOnMainQueue()
			.sink(
				receiveValue: { [weak self] (server, pollingRateList, currentPollingRate) in
					let viewModel = SettingsPresenter.map(
						title: SettingsPresenter.title,
						pollingRateTitle: SettingsPresenter.pollingRateTitle,
						pollingRateList: pollingRateList,
						currentSelectedPollingRate: pollingRateList.firstIndex(of: currentPollingRate) ?? 0,
						serversTitle: SettingsPresenter.serverTitle,
						currentServerName: server?.name ?? SettingsPresenter.serverNotAvailable
					)
					self?.settingsViewModel.newValues(viewModel)
				}
			)
	}
	
	func selectedPollingRate(_ pollingRate: String, fromPollingRateList pollingRateList: [String]) {
		guard let newPollingRateIndex = pollingRateList.firstIndex(of: pollingRate) else { return }
		UserDefaultsHandler.shared.pollingRate = PollingRateHandler.pollingRateList[newPollingRateIndex]
	}
	
}

private extension SettingsViewModel {
	func newValues(_ viewModel: SettingsViewModel) {
		title = viewModel.title
		pollingRateTitle = viewModel.pollingRateTitle
		pollingRateList = viewModel.pollingRateList
		currentSelectedPollingRate = viewModel.currentSelectedPollingRate
		serversTitle = viewModel.serversTitle
		currentServerName = viewModel.currentServerName
	}
}
