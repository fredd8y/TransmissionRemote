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
	}
	
	private let serversViewModel: ServerPageViewModel
	
	private var cancellable: Cancellable?
	
	private var selectionCancellable: Cancellable?
	
	private let serverFileName = "servers.json"
	
	private lazy var url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appending(component: serverFileName)
	
	func selectServer(_ id: UUID) {
		guard let url else { return }
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
		guard let url else { return }
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
	}
}
