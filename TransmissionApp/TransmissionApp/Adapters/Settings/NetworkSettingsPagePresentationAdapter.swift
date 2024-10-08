//
//  NetworkSettingsPagePresentationAdapter.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 29/08/23.
//

import Combine
import SwiftUI
import Foundation
import Transmission
import TransmissioniOS

class NetworkSettingsPagePresentationAdapter {
	
	@ObservedObject private var networkSettingsViewModel: NetworkSettingsPageViewModel = .loading()
	
	private var cancellables = Set<AnyCancellable>()
	
	func peerPortRandomOnStartChange(_ enabled: Bool) {
		guard let server = UserDefaultsHandler.shared.currentServer else { return }
		NetworkSettingsPublishers.makePortRandomOnStartChangePublisher(enabled: enabled, server: server)
			.sink(receiveCompletion: receiveCompletion, receiveValue: receiveValue)
			.store(in: &cancellables)
	}
	
	func portForwardingEnabledChange(_ enabled: Bool) {
		guard let server = UserDefaultsHandler.shared.currentServer else { return }
		NetworkSettingsPublishers.makePortForwardingChangePublisher(enabled: enabled, server: server)
			.sink(receiveCompletion: receiveCompletion, receiveValue: receiveValue)
			.store(in: &cancellables)
	}
	
	func utpEnabledChange(_ enabled: Bool) {
		guard let server = UserDefaultsHandler.shared.currentServer else { return }
		NetworkSettingsPublishers.makeUtpEnabledChangePublisher(enabled: enabled, server: server)
			.sink(receiveCompletion: receiveCompletion, receiveValue: receiveValue)
			.store(in: &cancellables)
	}
	
	func listeningPortChange(_ newPort: String) {
		networkSettingsViewModel.peerPortError = false
		guard let server = UserDefaultsHandler.shared.currentServer else { return }
		guard let port = Int(newPort) else {
			networkSettingsViewModel.peerPortError = true
			return
		}
		NetworkSettingsPublishers.makeListeningPortChangePublisher(port: port, server: server)
			.sink(receiveCompletion: receiveCompletion, receiveValue: receiveValue)
			.store(in: &cancellables)
	}
	
	func loadData() {
		cancelCurrentLoadingTasks()
		guard let server = UserDefaultsHandler.shared.currentServer else { return }
		NetworkSettingsPublishers.makeNetworkSettingsGetPublisher(server: server)
			.dispatchOnMainQueue()
			.sink(
				receiveCompletion: { [weak self] completion in
					switch completion {
					case .finished: break
					case .failure(let error):
						self?.networkSettingsViewModel.errorMessage = error.localizedDescription
					}
				},
				receiveValue: { [weak self] (networkSettings, portStatus) in
					let viewModel = NetworkSettingsPagePresenter.map(
						peerPort: networkSettings.peerPort,
						peerPortRandomOnStart: networkSettings.peerPortRandomOnStart,
						portForwardingEnabled: networkSettings.portForwardingEnabled,
						utpEnabled: networkSettings.utpEnabled,
						portOpen: portStatus
					)
					self?.networkSettingsViewModel.newValues(viewModel)
				}
			).store(in: &cancellables)
	}
	
	func showNetworkSettingsPage() -> NetworkSettingsPage {
		NetworkSettingsPage(viewModel: networkSettingsViewModel)
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
					networkSettingsViewModel.errorMessage = errorDescription
				}
			}
		}
	}
	
	private func receiveValue() {}
	
}

private extension NetworkSettingsPageViewModel {
	func newValues(_ viewModel: NetworkSettingsPageViewModel) {
		errorMessage = viewModel.errorMessage
		isLoading = viewModel.isLoading
		peerPort = viewModel.peerPort
		peerPortError = viewModel.peerPortError
		peerPortRandomOnStart = viewModel.peerPortRandomOnStart
		portForwardingEnabled = viewModel.portForwardingEnabled
		utpEnabled = viewModel.utpEnabled
		portStatus = viewModel.portStatus
	}
}
