//
//  ServerSetMapper.swift
//  Transmission
//
//  Created by Federico Arvat on 28/07/23.
//

import Foundation

public final class ServerSetMapper {
	public static func map(_ servers: [Server]) throws -> Data {
		let remoteServers = servers.map { $0.remoteServer }
		return try JSONEncoder().encode(remoteServers)
	}
}

private extension Server {
	var remoteServer: RemoteServer {
		RemoteServer(
			name: name,
			httpProtocol: httpProtocol.remoteHttpProtocol,
			ip: ip,
			port: port,
			username: username,
			password: password,
			id: id
		)
	}
}

private extension HTTPProtocol {
	var remoteHttpProtocol: RemoteServer.RemoteHTTPProtocol {
		switch self {
		case .http:
			return .http
		case .https:
			return .https
		}
	}
}
