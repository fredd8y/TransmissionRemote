//
//  PeersSettingsPagePresentationAdapter.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 28/08/23.
//

import Combine
import SwiftUI
import Foundation
import Transmission
import TransmissioniOS

class PeersSettingsPagePresentationAdapter {
	
	@ObservedObject private var peersSettingsViewModel: PeersSettingsPageViewModel = .loading()
	
	private var cancellables = Set<AnyCancellable>()
	
	func onBlocklistUpdate(_ url: String) {
		peersSettingsViewModel.isUpdatingBlocklist = true
		guard let server = UserDefaultsHandler.shared.currentServer else { return }
		PeersSettingsPublishers.makeBlocklistUpdatePublisher(url: url, server: server)
			.sink(
				receiveCompletion: { [weak self] completion in
					Task {
						await MainActor.run {
							self?.peersSettingsViewModel.isUpdatingBlocklist = false
							self?.peersSettingsViewModel.blocklistSize = PeersSettingsPagePresenter.mapBlocklistSize(0)
							self?.receiveCompletionAndShowAlertErrorIfNeeded(completion)
						}
					}
				},
				receiveValue: { [weak self] blocklistSize in
					Task {
						await MainActor.run {
							let _blocklistSize = blocklistSize ?? 0
							self?.peersSettingsViewModel.blocklistSize = PeersSettingsPagePresenter.mapBlocklistSize(_blocklistSize)
						}
					}
				}
			)
			.store(in: &cancellables)
	}
	
	func onEncryptionChange(_ encryption: PeersSettingsPageViewModel.Encryption) {
		guard let server = UserDefaultsHandler.shared.currentServer else { return }
		PeersSettingsPublishers.makeEncryptionSetPublisher(value: encryption.peersSettingsValue.rawValue, server: server)
			.sink(receiveCompletion: receiveCompletion, receiveValue: receiveValue)
			.store(in: &cancellables)
	}
	
	func onPexEnabledChange(_ enabled: Bool) {
		guard let server = UserDefaultsHandler.shared.currentServer else { return }
		PeersSettingsPublishers.makePexEnabledSetPublisher(enabled: enabled, server: server)
			.sink(receiveCompletion: receiveCompletion, receiveValue: receiveValue)
			.store(in: &cancellables)
	}
	
	func onDhtEnabledChange(_ enabled: Bool) {
		guard let server = UserDefaultsHandler.shared.currentServer else { return }
		PeersSettingsPublishers.makeDhtEnabledSetPublisher(enabled: enabled, server: server)
			.sink(receiveCompletion: receiveCompletion, receiveValue: receiveValue)
			.store(in: &cancellables)
	}
	
	func onLpdEnabledChange(_ enabled: Bool) {
		guard let server = UserDefaultsHandler.shared.currentServer else { return }
		PeersSettingsPublishers.makeLpdEnabledSetPublisher(enabled: enabled, server: server)
			.sink(receiveCompletion: receiveCompletion, receiveValue: receiveValue)
			.store(in: &cancellables)
	}
	
	func onBlocklistEnabledChange(_ enabled: Bool) {
		guard let server = UserDefaultsHandler.shared.currentServer else { return }
		PeersSettingsPublishers.makeBlocklistEnabledSetPublisher(enabled: enabled, server: server)
			.sink(receiveCompletion: receiveCompletion, receiveValue: receiveValue)
			.store(in: &cancellables)
	}
	
	func onPeerLimitGlobalChange(_ newLimit: String) {
		peersSettingsViewModel.peerLimitGlobalError = false
		guard let server = UserDefaultsHandler.shared.currentServer else { return }
		guard let limit = Int(newLimit) else {
			peersSettingsViewModel.peerLimitGlobalError = true
			return
		}
		PeersSettingsPublishers.makeGlobalPeerLimitSetPublisher(limit: limit, server: server)
			.sink(receiveCompletion: receiveCompletion, receiveValue: receiveValue)
			.store(in: &cancellables)
	}
	
	func onPeerLimitPerTorrentChange(_ newLimit: String) {
		peersSettingsViewModel.peerLimitPerTorrentError = false
		guard let server = UserDefaultsHandler.shared.currentServer else { return }
		guard let limit = Int(newLimit) else {
			peersSettingsViewModel.peerLimitPerTorrentError = true
			return
		}
		PeersSettingsPublishers.makePeerLimitPerTorrentSetPublisher(limit: limit, server: server)
			.sink(receiveCompletion: receiveCompletion, receiveValue: receiveValue)
			.store(in: &cancellables)
	}
	
	func onBlocklistUrlChange(_ blocklistUrl: String) {
		peersSettingsViewModel.blocklistUrlError = false
		guard let server = UserDefaultsHandler.shared.currentServer else { return }
		guard let _ = URL(string: blocklistUrl) else {
			peersSettingsViewModel.blocklistUrlError = true
			return
		}
		PeersSettingsPublishers.makeBlocklistUrlSetPublisher(url: blocklistUrl, server: server)
			.sink(receiveCompletion: receiveCompletion, receiveValue: receiveValue)
			.store(in: &cancellables)
	}
	
	func loadData() {
		cancelCurrentLoadingTasks()
		guard let server = UserDefaultsHandler.shared.currentServer else { return }
		PeersSettingsPublishers.makePeersSettingsGetPublisher(server: server)
			.dispatchOnMainQueue()
			.sink(
				receiveCompletion: { [weak self] completion in
					switch completion {
					case .finished: break
					case .failure(let error):
						self?.peersSettingsViewModel.newValues(.error(error.localizedDescription))
					}
				},
				receiveValue: { [weak self] peersSettings in
					let viewModel = PeersSettingsPagePresenter.map(peersSettings)
					self?.peersSettingsViewModel.newValues(viewModel)
				}
			).store(in: &cancellables)
	}
	
	func showPeersSettingsPage() -> PeersSettingsPage {
		PeersSettingsPage(viewModel: peersSettingsViewModel)
	}
	
	func stopLoadingData() {
		cancelCurrentLoadingTasks()
	}
	
	func encryptionDescription(_ encryptionDescription: PeersSettingsPageViewModel.Encryption) -> String {
		switch encryptionDescription {
		case .required:
			return PeersSettingsPagePresenter.requiredEncryptionDescription
		case .preferred:
			return PeersSettingsPagePresenter.preferredEncryptionDescription
		case .tolerated:
			return PeersSettingsPagePresenter.toleratedEncryptionDescription
		}
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
					peersSettingsViewModel.errorMessage = errorDescription
				}
			}
		}
	}
	
	private func receiveCompletionAndShowAlertErrorIfNeeded(_ completion: Subscribers.Completion<Error>) {
		switch completion {
		case .finished: break
		case .failure(let error):
			var errorDescription: String = ""
			guard let _error = error as? BlocklistUpdateMapper.Error, case let BlocklistUpdateMapper.Error.failed(explanation) = _error else {
				errorDescription = error.localizedDescription
				return
			}
			errorDescription = explanation
			Task {
				await MainActor.run {
					peersSettingsViewModel.alertMessage = errorDescription
					peersSettingsViewModel.alertMessageVisible = true
				}
			}
		}
	}
	
	private func receiveValue() {}
	
}

private extension PeersSettingsPageViewModel {
	func newValues(_ viewModel: PeersSettingsPageViewModel) {
		alertMessage = viewModel.alertMessage
		alertMessageVisible = viewModel.alertMessageVisible
		errorMessage = viewModel.errorMessage
		isLoading = viewModel.isLoading
		peerLimitGlobal = viewModel.peerLimitGlobal
		peerLimitGlobalError = viewModel.peerLimitGlobalError
		peerLimitPerTorrent = viewModel.peerLimitPerTorrent
		peerLimitPerTorrentError = viewModel.peerLimitPerTorrentError
		pexEnabled = viewModel.pexEnabled
		dhtEnabled = viewModel.dhtEnabled
		lpdEnabled = viewModel.lpdEnabled
		blocklistEnabled = viewModel.blocklistEnabled
		blocklistSize = viewModel.blocklistSize
		blocklistUrl = viewModel.blocklistUrl
		blocklistUrlError = viewModel.blocklistUrlError
		encryption = viewModel.encryption
	}
}

private extension PeersSettingsPageViewModel.Encryption {
	var peersSettingsValue: PeersSettings.Encryption {
		switch self {
		case .required: return .required
		case .preferred: return .preferred
		case .tolerated: return .tolerated
		}
	}
}
