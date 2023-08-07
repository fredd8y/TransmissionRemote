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
	
	func showServerDetail(_ id: UUID) -> ServerDetailPage? {
		guard let url = ServerFile.url else { return nil }
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
			// Name check
			guard model.name != "" else {
				return ServerDetailPageError.name
			}
			// IP check
			guard model.ip != "" else {
				return ServerDetailPageError.name
			}
			let ipComponents = model.ip.components(separatedBy: ".")
			guard ipComponents.count == 4 else {
				return ServerDetailPageError.ip
			}
			let wrongComponents = ipComponents.filter {
				guard let number = Int($0) else { return true }
				return number < 0 && number > 255
			}
			if wrongComponents.count > 0 {
				return ServerDetailPageError.ip
			}
			// Port check
			guard model.port != "", let intPort = Int(model.port), intPort >= 1, intPort <= 65535 else {
				return ServerDetailPageError.port
			}
			// Username and Password check
			if (model.username != "" && model.password == "") || (model.password != "" && model.username == "") {
				if model.username == "" {
					return ServerDetailPageError.username
				}
				if model.password == "" {
					return ServerDetailPageError.password
				}
			}
			let server = Server(
				name: model.name,
				httpProtocol: model.httpProtocol,
				ip: model.ip,
				port: intPort,
				username: model.username == "" ? nil : model.username,
				password: model.password == "" ? nil : try Cipher.encryptPassword(model.password, withKey: try Cipher.generateSymmetricKey(withPassword: try Keychain.getPasswordKey())),
				id: model.id
			)
			guard let url = ServerFile.url else { return nil }
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
