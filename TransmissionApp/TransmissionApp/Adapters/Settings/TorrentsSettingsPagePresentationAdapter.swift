//
//  TorrentsSettingsPagePresentationAdapter.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 22/08/23.
//

import Combine
import SwiftUI
import Foundation
import Transmission
import TransmissioniOS

class TorrentsSettingsPagePresentationAdapter {
	
	@ObservedObject private var torrentsSettingsViewModel: TorrentsSettingsPageViewModel = .loading()
		
	private var cancellables = Set<AnyCancellable>()
	
	func setRenamePartialFiles(_ enabled: Bool) {
		guard let server = UserDefaultsHandler.shared.currentServer else { return }
		TorrentsSettingsPublishers.makeRenamePartialFilesSetPublisher(enabled: enabled, server: server)
			.sink(receiveCompletion: receiveCompletion, receiveValue: receiveValue)
			.store(in: &cancellables)
	}
	
	func setStartAddedTorrent(_ enabled: Bool) {
		guard let server = UserDefaultsHandler.shared.currentServer else { return }
		TorrentsSettingsPublishers.makeStartAddedTorrentSetPublisher(enabled: enabled, server: server)
			.sink(receiveCompletion: receiveCompletion, receiveValue: receiveValue)
			.store(in: &cancellables)
	}
	
	func loadData() {
		cancelCurrentLoadingTasks()
		guard let server = UserDefaultsHandler.shared.currentServer else { return }
		TorrentsSettingsPublishers.makeTorrentsSettingsGetPublisher(server: server)
			.dispatchOnMainQueue()
			.sink(
				receiveCompletion: { [weak self] completion in
					switch completion {
					case .finished: break
					case .failure(let error):
						self?.torrentsSettingsViewModel.newValues(.error(error.localizedDescription))
					}
				},
				receiveValue: { [weak self] torrentsSettings in
					let viewModel = TorrentsSettingsPagePresenter.map(torrentsSettings)
					self?.torrentsSettingsViewModel.newValues(viewModel)
				}
			).store(in: &cancellables)
	}
	
	func showTorrentsSettingsPage() -> TorrentsSettingsPage {
		TorrentsSettingsPage(viewModel: torrentsSettingsViewModel)
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
			torrentsSettingsViewModel.newValues(.error(error.localizedDescription))
		}
	}
	
	private func receiveValue() {
		loadData()
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
