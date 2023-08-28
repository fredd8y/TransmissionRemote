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
	
	func onBlocklistUpdate() {
		
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
			return "REQUIRED"
		case .preferred:
			return "PREFERRED"
		case .tolerated:
			return "TOLERATED"
		}
	}
	
	private func cancelCurrentLoadingTasks() {
		cancellables.removeAll()
	}
	
	private func receiveCompletion(_ completion: Subscribers.Completion<Error>) {
		switch completion {
		case .finished: break
		case .failure(let error):
			peersSettingsViewModel.newValues(.error(error.localizedDescription))
		}
	}
	
	private func receiveValue() {}
	
}

private extension PeersSettingsPageViewModel {
	func newValues(_ viewModel: PeersSettingsPageViewModel) {
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
