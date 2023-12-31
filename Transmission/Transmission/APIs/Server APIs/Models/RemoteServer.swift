//
//  RemoteServer.swift
//  Transmission
//
//  Created by Federico Arvat on 28/07/23.
//

import Foundation

struct RemoteServer: Codable {
	enum RemoteHTTPProtocol: String, Codable {
		case http
		case https
		
		var serverProtocol: HTTPProtocol {
			switch self {
			case .http: return .http
			case .https: return .https
			}
		}
	}
	
	let name: String
	let httpProtocol: RemoteHTTPProtocol
	let ip: String
	let port: Int
	let username: String?
	let password: String?
	let id: UUID
	
	var server: Server {
		Server(
			name: name,
			httpProtocol: httpProtocol.serverProtocol,
			ip: ip,
			port: port,
			username: username,
			password: password,
			id: id
		)
	}
}
