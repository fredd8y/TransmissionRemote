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
	
	init(serversViewModel: ServersViewModel) {
		self.serversViewModel = serversViewModel
	}
	
	private let serversViewModel: ServersViewModel
	
	private var cancellable: Cancellable?
	
	private let serverFileName = "servers.json"
	
	func loadData() {
		guard
			let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathExtension(serverFileName)
		else {
			// TODO: Handle error on SettingsPage
			return
		}
		cancellable = ServerPublishers.makeServerGetLoader(atUrl: url)
			.dispatchOnMainQueue()
			.sink(
				receiveCompletion: { completion in
					switch completion {
					case .finished: break
					case .failure(let error):
						// TODO: handle error
						break
					}
				},
				receiveValue: { [weak self] servers in
					let viewModel = ServersPresenter.map(
						title: ServersPresenter.title,
						servers: servers,
						currentSelectedServer: UserDefaultsHandler.shared.currentServer
					)
					self?.serversViewModel.newValues(viewModel)
				}
			)
	}
	
}

private extension ServersViewModel {
	func newValues(_ viewModel: ServersViewModel) {
		title = viewModel.title
		servers = viewModel.servers
		currentSelectedServer = viewModel.currentSelectedServer
	}
}
