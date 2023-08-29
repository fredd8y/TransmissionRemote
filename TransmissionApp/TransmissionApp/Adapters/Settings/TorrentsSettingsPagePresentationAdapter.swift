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
	
	func setDownloadDir(_ downloadDir: String) {
		torrentsSettingsViewModel.downloadDirError = false
		guard let server = UserDefaultsHandler.shared.currentServer else { return }
		guard let _ = URL(string: downloadDir) else {
			torrentsSettingsViewModel.downloadDirError = true
			return
		}
		TorrentsSettingsPublishers.makeDownloadDirSetPublisher(downloadDir: downloadDir, server: server)
			.sink(receiveCompletion: receiveCompletion, receiveValue: receiveValue)
			.store(in: &cancellables)
	}
	
	func setSeedRatioLimited(_ enabled: Bool) {
		guard let server = UserDefaultsHandler.shared.currentServer else { return }
		TorrentsSettingsPublishers.makeSeedRatioLimitedSetPublisher(enabled: enabled, server: server)
			.sink(receiveCompletion: receiveCompletion, receiveValue: receiveValue)
			.store(in: &cancellables)
	}
	
	func setSeedRatioLimit(_ newLimit: String) {
		torrentsSettingsViewModel.seedRatioLimitError = false
		guard let server = UserDefaultsHandler.shared.currentServer else { return }
		guard let limit = Int(newLimit) else {
			torrentsSettingsViewModel.seedRatioLimitError = true
			return
		}
		TorrentsSettingsPublishers.makeSeedRatioLimitSetPublisher(limit: limit, server: server)
			.sink(receiveCompletion: receiveCompletion, receiveValue: receiveValue)
			.store(in: &cancellables)
	}
	
	func setIdleSeedingLimitEnabled(_ enabled: Bool) {
		guard let server = UserDefaultsHandler.shared.currentServer else { return }
		TorrentsSettingsPublishers.makeIdleSeedingLimitEnabledSetPublisher(enabled: enabled, server: server)
			.sink(receiveCompletion: receiveCompletion, receiveValue: receiveValue)
			.store(in: &cancellables)
	}
	
	func setIdleSeedingLimit(_ newLimit: String) {
		torrentsSettingsViewModel.seedRatioLimitError = false
		guard let server = UserDefaultsHandler.shared.currentServer else { return }
		guard let limit = Int(newLimit) else {
			torrentsSettingsViewModel.idleSeedingLimitError = true
			return
		}
		TorrentsSettingsPublishers.makeIdleSeedingLimitSetPublisher(limit: limit, server: server)
			.sink(receiveCompletion: receiveCompletion, receiveValue: receiveValue)
			.store(in: &cancellables)
	}
	
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
			var errorDescription: String = ""
			guard let _error = error as? SessionSetMapper.Error, case let SessionSetMapper.Error.failed(explanation) = _error else {
				errorDescription = error.localizedDescription
				return
			}
			errorDescription = explanation
			Task {
				await MainActor.run {
					torrentsSettingsViewModel.errorMessage = errorDescription
				}
			}
		}
	}
	
	private func receiveValue() {}
	
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
