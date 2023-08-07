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
	
	internal init(settingsViewModel: SettingsViewModel) {
		self.settingsViewModel = settingsViewModel
	}
	
	private var settingsViewModel: SettingsViewModel
	
	private var cancellable: Cancellable?
	
	private let serverFileName = "servers.json"
		
	func loadData() {
		guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathExtension(serverFileName) else {
			// TODO: Handle error on SettingsPage
			return
		}
		cancellable = Publishers.Zip3(
			ServerPublishers.makeServerGetLoader(atUrl: url),
			PollingRateHandler.makeUpdatePollingRateLoader(),
			PollingRateHandler.makeCurrentPollingRateLoader()
		)
			.dispatchOnMainQueue()
			.sink(
				receiveCompletion: { [weak self] completion in
					switch completion {
					case .finished: break
					case .failure(let error):
						// The only error that we can receive here is on file opening,
						// that means the the file does not exist
						// we create an empty server file and we relaunch loadData()
						if error is ServerPublishers.Error {
							do {
								try JSONEncoder().encode(try ServerSetMapper.map([])).write(to: url)
								self?.loadData()
							} catch {
								// TODO: Handle error on SettingsPage
							}
						}
						break
					}
				},
				receiveValue: { [weak self] (servers, pollingRateList, currentPollingRate) in
					let viewModel = SettingsPresenter.map(
						title: SettingsPresenter.title,
						pollingRateTitle: SettingsPresenter.pollingRateTitle,
						pollingRateList: pollingRateList,
						currentSelectedPollingRate: pollingRateList.firstIndex(of: currentPollingRate) ?? 0,
						serversTitle: SettingsPresenter.serverTitle,
						currentServerName: UserDefaultsHandler.shared.currentServer?.name ?? SettingsPresenter.serverNotAvailable
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
