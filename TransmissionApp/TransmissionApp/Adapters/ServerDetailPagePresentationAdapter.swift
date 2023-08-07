//
//  ServerDetailPagePresentationAdapter.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 31/07/23.
//

import Combine
import Foundation
import Transmission
import TransmissioniOS

class ServerDetailPagePresentationAdapter {
	
	private var cancellable: Cancellable?
	
	private let serverFileName = "servers.json"
		
	private lazy var url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathExtension(serverFileName)
	
	func showServerDetail(_ id: UUID) -> ServerDetailPage? {
		guard let url else { return nil }
		do {
			guard let server = try ServerGetMapper.map(try Data(contentsOf: url)).first(where: { $0.id == id }) else {
				return nil
			}
			return serverDetailPage(viewModel: ServerDetailPageViewModel(server: server))
		} catch {
			return nil
		}
	}
	
	func save(_ model: ServerDetailPageDataModel) -> Error? {
		do {
			guard model.name != "" else {
				// TODO: Handle validation error
				return nil
			}
			guard model.ip != "" else {
				// TODO: Handle validation error
				return nil
			}
			guard model.port != "", let intPort = Int(model.port) else {
				// TODO: Handle validation error
				return nil
			}
			if (model.username != "" && model.name == "") || (model.username == "" && model.username != "") {
				// TODO: Handle validation error
				return nil
			}
			let server = Server(
				name: model.name,
				httpProtocol: model.httpProtocol,
				ip: model.ip,
				port: intPort,
				username: model.username,
				password: model.password,
				id: model.id
			)
			guard let url else {
				// TODO: Handle error
				return nil
			}
			var servers = try ServerGetMapper.map(try Data(contentsOf: url))
			if let index = servers.firstIndex(where: { $0.id == model.id }) {
				servers[index] = server
			} else {
				servers.append(server)
			}
			try ServerSetMapper.map(servers).write(to: url)
			UserDefaultsHandler.shared.currentServer = server
		} catch {
			// TODO: Handle error
			dump(error)
		}
		return nil
	}
	
	func newServer() -> ServerDetailPage {
		return serverDetailPage(viewModel: ServerDetailPageViewModel())
	}
	
	private func serverDetailPage(viewModel: ServerDetailPageViewModel) -> ServerDetailPage {
		var serverDetailPage = ServerDetailPage(viewModel: viewModel)
		serverDetailPage.save = save
		return serverDetailPage
	}
	
}
