//
//  SettingsPagePresentationAdapter.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 27/07/23.
//

import Combine
import Transmission

class SettingsPagePresentationAdapter {
	
	internal init(settingsViewModel: SettingsViewModel) {
		self.settingsViewModel = settingsViewModel
	}
	
	private var settingsViewModel: SettingsViewModel
	
	private var cancellable: Cancellable?
		
	func loadData() {
		cancellable = Publishers.Zip3(
			ServerHandler.makeServerLoader(),
			UpdateIntervalHandler.makeUpdateIntervalListLoader(),
			UpdateIntervalHandler.makeCurrentUpdateIntervalLoader()
		)
			.dispatchOnMainQueue()
			.sink(
				receiveCompletion: { completion in
					switch completion {
					case .finished: break
					case .failure:
						// TODO: handle error in settings view
						break
					}
				},
				receiveValue: { (servers, updateIntervals, currentUpdateInterval) in
					let viewModel = SettingsPresenter.map(
						title: SettingsPresenter.title,
						updateIntervalTitle: SettingsPresenter.updateIntervalTitle,
						updateIntervalList: updateIntervals,
						currentSelectedIntervalIndex: currentUpdateInterval,
						serversTitle: SettingsPresenter.serverTitle,
						currentServerName: servers.first(where: { $0.selected })?.name ?? "Not defined"
					)
				}
			)
	}
}

private extension SettingsViewModel {
	func newValues(_ viewModel: SettingsViewModel) {
		title = viewModel.title
		updateIntervalTitle = viewModel.updateIntervalTitle
		updateIntervalList = viewModel.updateIntervalList
		currentSelectedIntervalIndex = viewModel.currentSelectedIntervalIndex
		serversTitle = viewModel.serversTitle
		currentServerName = viewModel.currentServerName
	}
}
