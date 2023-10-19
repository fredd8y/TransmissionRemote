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
			var password: String?
			if let encryptedPassword = server.password {
				if let passwordKey = try? Keychain.getPasswordKey(), let symmetricKey = try? Cipher.generateSymmetricKey(withPassword: passwordKey) {
					password = try? Cipher.decryptPassword(encryptedPassword, withKey: symmetricKey)
				}
			}
			return serverDetailPage(
				viewModel: ServerDetailPageViewModel(server: Server(
					name: server.name,
					httpProtocol: server.httpProtocol,
					ip: server.ip,
					port: server.port,
					username: server.username,
					password: password,
					id: server.id
				))
			)
		} catch {
			return nil
		}
	}
	
	func save(_ model: ServerDetailPageDataModel) -> Error? {
		// Name check
		guard model.name != "" else {
			return ServerDetailPageError.name
		}
		// IP check
		guard model.ip != "" else {
			return ServerDetailPageError.ip
		}
		let ipComponents = model.ip.components(separatedBy: ".")
		guard ipComponents.count == 4 else {
			return ServerDetailPageError.ip
		}
		let wrongComponents = ipComponents.filter {
			guard let number = Int($0) else { return true }
			return number < 0 || number > 255
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
		guard
			let passwordKey = try? Keychain.getPasswordKey(),
			let symmetricKey = try? Cipher.generateSymmetricKey(withPassword: passwordKey),
			let password = try? Cipher.encryptPassword(model.password, withKey: symmetricKey)
		else { return ServerDetailPageError.alert(message: ServerDetailPagePresenter.undefinedError) }
		let server = Server(
			name: model.name,
			httpProtocol: model.httpProtocol,
			ip: model.ip,
			port: intPort,
			username: model.username == "" ? nil : model.username,
			password: model.password == "" ? nil : password,
			id: model.id
		)
		guard
			let url = ServerFile.url,
			let fileData = try? Data(contentsOf: url),
			var servers = try? ServerGetMapper.map(fileData)
		else { return ServerDetailPageError.alert(message: ServerDetailPagePresenter.undefinedError) }
		if let index = servers.firstIndex(where: { $0.id == model.id }) {
			servers[index] = server
		} else {
			servers.append(server)
		}
		do {
			try ServerSetMapper.map(servers).write(to: url)
		} catch {
			return ServerDetailPageError.alert(message: ServerDetailPagePresenter.undefinedError)
		}
		UserDefaultsHandler.shared.currentServer = server
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
