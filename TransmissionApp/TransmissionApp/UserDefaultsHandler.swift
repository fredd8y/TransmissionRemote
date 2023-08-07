//
//  UserDefaultsHandler.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 28/07/23.
//

import Foundation
import Transmission

// MARK: - UserDefaultsKeys

enum UserDefaultsKeys: String {
	case pollingRate
	case serverIp
	case serverId
	case serverName
	case serverPort
	case serverUsername
	case serverPassword
	case serverHTTPProtocol
}

// MARK: - UserDefaultsHandler

class UserDefaultsHandler {
	// MARK: Lifecycle
	
	private init() {
		if let value = UserDefaults.standard.value(forKey: UserDefaultsKeys.pollingRate.rawValue) as? Int {
			pollingRate = value
		} else {
			pollingRate = 5
		}
		if
			let serverName = UserDefaults.standard.string(forKey: UserDefaultsKeys.serverName.rawValue),
			let stringHTTPProtocol = UserDefaults.standard.string(forKey: UserDefaultsKeys.serverHTTPProtocol.rawValue),
			let httpProtocol = HTTPProtocol(rawValue: stringHTTPProtocol),
			let serverIp = UserDefaults.standard.string(forKey: UserDefaultsKeys.serverIp.rawValue),
			let serverPort = UserDefaults.standard.value(forKey: UserDefaultsKeys.serverPort.rawValue) as? Int,
			let serverIdString = UserDefaults.standard.value(forKey: UserDefaultsKeys.serverId.rawValue) as? String,
			let serverId = UUID(uuidString: serverIdString)
		{
			currentServer = Server(
				name: serverName,
				httpProtocol: httpProtocol,
				ip: serverIp,
				port: serverPort,
				username: UserDefaults.standard.string(forKey: UserDefaultsKeys.serverUsername.rawValue),
				password: UserDefaults.standard.string(forKey: UserDefaultsKeys.serverPassword.rawValue),
				id: serverId
			)
		}
	}
	
	// MARK: Internal
	
	static let shared = UserDefaultsHandler()
	
	@Published var pollingRate: Int {
		didSet {
			setPollingRate(pollingRate)
		}
	}
	
	@Published var currentServer: Server? {
		didSet {
			if let currentServer {
				setServerName(currentServer.name)
				setServerHTTPProtocol(currentServer.httpProtocol.rawValue)
				setServerIp(currentServer.ip)
				setServerPort(currentServer.port)
				setServerUsername(currentServer.username)
				setServerPassword(currentServer.password)
				setServerId(currentServer.id)
			} else {
				removeServer()
			}
		}
	}
	
	// MARK: - Polling rate
	
	private func setPollingRate(_ pollingRate: Int) {
		UserDefaults.standard.setValue(pollingRate, forKey: UserDefaultsKeys.pollingRate.rawValue)
	}
	
	// MARK: - Server configuration
	
	private func setServerIp(_ ip: String) {
		UserDefaults.standard.setValue(ip, forKey: UserDefaultsKeys.serverIp.rawValue)
	}
	
	private func setServerId(_ id: UUID) {
		UserDefaults.standard.setValue(id.uuidString, forKey: UserDefaultsKeys.serverId.rawValue)
	}
	
	private func setServerPort(_ port: Int) {
		UserDefaults.standard.setValue(port, forKey: UserDefaultsKeys.serverPort.rawValue)
	}
	
	private func setServerName(_ name: String) {
		UserDefaults.standard.setValue(name, forKey: UserDefaultsKeys.serverName.rawValue)
	}
	
	private func setServerUsername(_ username: String?) {
		UserDefaults.standard.setValue(username, forKey: UserDefaultsKeys.serverUsername.rawValue)
	}
	
	private func setServerPassword(_ password: String?) {
		UserDefaults.standard.setValue(password, forKey: UserDefaultsKeys.serverPassword.rawValue)
	}
	
	private func setServerHTTPProtocol(_ httpProtocol: String) {
		UserDefaults.standard.setValue(httpProtocol, forKey: UserDefaultsKeys.serverHTTPProtocol.rawValue)
	}
	
	private func removeServer() {
		UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.serverIp.rawValue)
		UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.serverId.rawValue)
		UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.serverName.rawValue)
		UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.serverPort.rawValue)
		UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.serverUsername.rawValue)
		UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.serverPassword.rawValue)
		UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.serverHTTPProtocol.rawValue)
	}
	
}
