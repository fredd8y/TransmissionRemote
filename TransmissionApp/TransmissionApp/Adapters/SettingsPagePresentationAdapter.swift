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
			UpdateIntervalHandler.makeUpdateIntervalListLoader(),
			UpdateIntervalHandler.makeCurrentUpdateIntervalLoader()
		)
			.dispatchOnMainQueue()
			.sink(
				receiveCompletion: { [weak self] completion in
					switch completion {
					case .finished: break
					case .failure(let error):
						// The only error that we can receive here is on file opening,
						// that means the the file is non-existing
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
				receiveValue: { [weak self] (servers, updateIntervals, currentUpdateInterval) in
					let viewModel = SettingsPresenter.map(
						title: SettingsPresenter.title,
						updateIntervalTitle: SettingsPresenter.updateIntervalTitle,
						updateIntervalList: updateIntervals,
						currentSelectedIntervalIndex: updateIntervals.firstIndex(of: currentUpdateInterval) ?? 0,
						serversTitle: SettingsPresenter.serverTitle,
						currentServerName: servers.first(where: { $0.selected })?.name ?? SettingsPresenter.serverNotAvailable
					)
					self?.settingsViewModel.newValues(viewModel)
				}
			)
	}
}

private extension SettingsViewModel {
	func newValues(_ viewModel: SettingsViewModel) {
		title = viewModel.title
		updateIntervalTitle = viewModel.updateIntervalTitle
		updateIntervalList = viewModel.updateIntervalList
		currentSelectedInterval = viewModel.currentSelectedInterval
		serversTitle = viewModel.serversTitle
		currentServerName = viewModel.currentServerName
	}
}
