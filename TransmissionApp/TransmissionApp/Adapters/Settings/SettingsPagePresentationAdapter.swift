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
	
	init(settingsViewModel: SettingsPageViewModel) {
		self.settingsViewModel = settingsViewModel
		
		serverCancellable = UserDefaultsHandler.shared.currentServerPublisher.sink { [weak self] newValue in
			self?.loadData()
		}
	}
	
	private var settingsViewModel: SettingsPageViewModel
	
	private var cancellable: Cancellable?
	private var serverCancellable: Cancellable?
		
	func loadData() {
		cancellable = Publishers.Zip(
			PollingRateHandler.makeUpdatePollingRateLoader(),
			PollingRateHandler.makeCurrentPollingRateLoader()
		)
			.dispatchOnMainQueue()
			.sink(
				receiveValue: { [weak self] (pollingRateList, currentPollingRate) in
					let viewModel = SettingsPagePresenter.map(
						title: SettingsPagePresenter.title,
						pollingRateTitle: SettingsPagePresenter.pollingRateTitle,
						pollingRateList: pollingRateList,
						currentSelectedPollingRate: pollingRateList.firstIndex(of: currentPollingRate) ?? 0,
						serversTitle: SettingsPagePresenter.serverTitle,
						currentServerName: UserDefaultsHandler.shared.currentServer?.name ?? SettingsPagePresenter.serverNotAvailable
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

private extension SettingsPageViewModel {
	func newValues(_ viewModel: SettingsPageViewModel) {
		title = viewModel.title
		pollingRateTitle = viewModel.pollingRateTitle
		pollingRateList = viewModel.pollingRateList
		currentSelectedPollingRate = viewModel.currentSelectedPollingRate
		serversTitle = viewModel.serversTitle
		currentServerName = viewModel.currentServerName
	}
}
