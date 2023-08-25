//
//  SpeedSettingsPagePresentationAdapter.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 25/08/23.
//

import Combine
import SwiftUI
import Foundation
import Transmission
import TransmissioniOS

class SpeedSettingsPagePresentationAdapter {
	
	@ObservedObject private var speedSettingsViewModel: SpeedSettingsPageViewModel = .loading()
	
	private var cancellables = Set<AnyCancellable>()
	
	func loadData() {
		cancelCurrentLoadingTasks()
		guard let server = UserDefaultsHandler.shared.currentServer else { return }
		SpeedSettingsPublishers.makeSpeedSettingsGetPublisher(server: server)
			.dispatchOnMainQueue()
			.sink(
				receiveCompletion: { [weak self] completion in
					switch completion {
					case .finished: break
					case .failure(let error):
						self?.speedSettingsViewModel.newValues(.error(error.localizedDescription))
					}
				},
				receiveValue: { [weak self] speedSettings in
					let viewModel = SpeedSettingsPagePresenter.map(speedSettings)
					self?.speedSettingsViewModel.newValues(viewModel)
				}
			).store(in: &cancellables)
	}
	
	func showSpeedSettingsPage() -> SpeedSettingsPage {
		SpeedSettingsPage(viewModel: speedSettingsViewModel)
	}
	
	func stopLoadingData() {
		cancelCurrentLoadingTasks()
	}
	
	private func cancelCurrentLoadingTasks() {
		cancellables.removeAll()
	}
	
	private func receiveCompletion(_ completion: Subscribers.Completion<Error>) {
		switch completion {
		case .finished: break
		case .failure(let error):
			speedSettingsViewModel.newValues(.error(error.localizedDescription))
		}
	}
	
}

private extension SpeedSettingsPageViewModel {
	func newValues(_ viewModel: SpeedSettingsPageViewModel) {
		isLoading = viewModel.isLoading
		errorMessage = viewModel.errorMessage
		uploadLimitEnabled = viewModel.uploadLimitEnabled
		uploadLimit = viewModel.uploadLimit
		uploadLimitError = viewModel.uploadLimitError
		downloadLimitEnabled = viewModel.downloadLimitEnabled
		downloadLimit = viewModel.downloadLimit
		downloadLimitError = viewModel.downloadLimitError
		alternativeUploadLimit = viewModel.alternativeUploadLimit
		alternativeUploadLimitError = viewModel.alternativeUploadLimitError
		alternativeDownloadLimit = viewModel.alternativeDownloadLimit
		alternativeDownloadLimitError = viewModel.alternativeDownloadLimitError
		scheduledTimesEnabled = viewModel.scheduledTimesEnabled
		alternativeSpeedTimeBegin = viewModel.alternativeSpeedTimeBegin
		alternativeSpeedTimeDay = viewModel.alternativeSpeedTimeDay
		alternativeSpeedTimeEnd = viewModel.alternativeSpeedTimeEnd
	}
}
