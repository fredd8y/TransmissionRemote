//
//  ServerPagePresentationAdapter.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 30/07/23.
//

import Combine
import Foundation
import Transmission

class ServerPagePresentationAdapter {
	
	init(serversViewModel: ServerPageViewModel) {
		self.serversViewModel = serversViewModel
		
		serverCancellable = UserDefaultsHandler.shared.currentServerPublisher.sink { [weak self] newValue in
			self?.loadData()
		}
	}
	
	private let serversViewModel: ServerPageViewModel
	
	private var cancellable: Cancellable?
	private var serverCancellable: Cancellable?
	private var deleteCancellable: Cancellable?
	private var selectionCancellable: Cancellable?
	
	private let serverFileName = "servers.json"
		
	func delete(_ id: UUID) {
		guard let url = ServerFile.url else { return }
		deleteCancellable = ServerPublishers.makeServerGetLoader(atUrl: url)
			.dispatchOnMainQueue()
			.sink(
				receiveCompletion: { _ in },
				receiveValue: { [weak self] servers in
					do {
						var _servers = servers
						_servers.removeAll(where: { $0.id == id })
						try ServerSetMapper.map(_servers).write(to: url)
						if UserDefaultsHandler.shared.currentServer?.id == id {
							UserDefaultsHandler.shared.currentServer = nil
						}
						self?.loadData()
					} catch {
						// TODO: show error alert
					}
				}
			)
	}
	
	func selectServer(_ id: UUID) {
		guard let url = ServerFile.url else { return }
		selectionCancellable = ServerPublishers.makeServerGetLoader(atUrl: url)
			.dispatchOnMainQueue()
			.sink(
				receiveCompletion: { _ in },
				receiveValue: { servers in
					guard let server = servers.first(where: { $0.id == id }) else { return }
					UserDefaultsHandler.shared.currentServer = server
				}
			)
	}
	
	func loadData() {
		guard let url = ServerFile.url else { return }
		cancellable = ServerPublishers.makeServerGetLoader(atUrl: url)
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
								Keychain.deleteAllGenericPassword()
								try Keychain.addPasswordKey(try Keychain.generateRandomPassword())
								try ServerSetMapper.map([]).write(to: url)
								self?.loadData()
							} catch {
								// TODO: Handle error on SettingsPage
							}
						}
						break
					}
				},
				receiveValue: { [weak self] servers in
					let viewModel = ServerPagePresenter.map(
						title: ServerPagePresenter.title,
						servers: servers,
						currentSelectedServer: UserDefaultsHandler.shared.currentServer
					)
					self?.serversViewModel.newValues(viewModel)
				}
			)
	}
	
}

private extension ServerPageViewModel {
	func newValues(_ viewModel: ServerPageViewModel) {
		title = viewModel.title
		servers = viewModel.servers
		currentSelectedServerId = viewModel.currentSelectedServerId
		emptyMessage = viewModel.emptyMessage
	}
}
