//
//  TorrentsSettingsPagePresentationAdapter.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 22/08/23.
//

import Combine
import Foundation
import Transmission
import TransmissioniOS

class TorrentsSettingsPagePresentationAdapter {
	
	private var torrentsSettingsViewModel: TorrentsSettingsPageViewModel!
		
	private var workItems: [DispatchWorkItem] = []
	private var cancellables = Set<AnyCancellable>()
	
	func showTorrentsSettingsPage() -> TorrentsSettingsPage {
		let viewModel = TorrentsSettingsPageViewModel.loading()
		torrentsSettingsViewModel = viewModel
		return TorrentsSettingsPage(viewModel: viewModel)
	}
	
	func stopLoadingData() {
		cancelCurrentLoadingTasks()
	}
	
	func loadData() {
		cancelCurrentLoadingTasks()
		guard let server = UserDefaultsHandler.shared.currentServer else {
			return
		}
		SessionSettingsPublishers.makeTorrentsSettingsGetPublisher(server: server)
			.dispatchOnMainQueue()
			.sink(
				receiveCompletion: { [weak self] completion in
					switch completion {
					case .finished: break
					case .failure(let error):
						self?.torrentsSettingsViewModel.newValues(TorrentsSettingsPageViewModel.error(error.localizedDescription))
					}
				},
				receiveValue: { [weak self] torrentsSettings in
					let viewModel = TorrentsSettingsPagePresenter.map(torrentsSettings)
					self?.torrentsSettingsViewModel.newValues(viewModel)
					let workItem = DispatchWorkItem { [weak self] in
						self?.loadData()
					}
					self?.workItems.append(workItem)
					DispatchQueue.main.asyncAfter(deadline: .now() + DispatchTimeInterval.seconds(UserDefaultsHandler.shared.pollingRate), execute: workItem)
				}
			)
			.store(in: &cancellables)
	}
	
	private func cancelCurrentLoadingTasks() {
		workItems.forEach { $0.cancel() }
		workItems.removeAll()
		cancellables.removeAll()
	}
}

private extension TorrentsSettingsPageViewModel {
	func newValues(_ viewModel: TorrentsSettingsPageViewModel) {
		downloadDir = viewModel.downloadDir
		startAddedTorrents = viewModel.startAddedTorrents
		renamePartialFiles = viewModel.renamePartialFiles
		seedRatioLimited = viewModel.seedRatioLimited
		seedRatioLimit = viewModel.seedRatioLimit
		idleSeedingLimitEnabled = viewModel.idleSeedingLimitEnabled
		idleSeedingLimit = viewModel.idleSeedingLimit
		errorMessage = viewModel.errorMessage
		isLoading = viewModel.isLoading
	}
}
