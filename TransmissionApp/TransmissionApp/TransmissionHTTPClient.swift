//
//  TransmissionHTTPClient.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 24/07/23.
//

import Combine
import Foundation
import Transmission

final class TransmissionHTTPClient {
	
	private init() {}
	
	static var sessionId: String?

	static func makeRemoteSessionLoader(server: Server) -> AnyPublisher<Session, Error> {
		return httpClient
			.postPublisher(
				url: APIsEndpoint.post.url(baseURL: server.baseURL),
				body: SessionBodies.get.data(using: .utf8)!,
				additionalHeader: headers(server)
			)
			.logResponse()
			.tryMap(SessionGetMapper.map)
			.eraseToAnyPublisher()
	}

	static func makeRemoteTorrentsLoader(server: Server) -> AnyPublisher<[Torrent], Error> {
		return httpClient
			.postPublisher(
				url: APIsEndpoint.post.url(baseURL: server.baseURL),
				body: TorrentBodies.get(TorrentField.minimumTorrentField),
				additionalHeader: headers(server)
			)
			.logResponse()
			.tryMap(TorrentGetMapper.map)
			.eraseToAnyPublisher()
	}

	// MARK: Private

	private static let httpClient: HTTPClient = URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))

	private static func headers(_ server: Server) -> [String: String] {
		var headers: [String: String] = [:]
		if let username = server.username, let password = server.password {
			headers[HeaderUtils.AUTHORIZATION_KEY] = HeaderUtils.basicAuthCredentialsString(username: username, password: password)
		}
		if let sessionId {
			headers[SessionGetMapper.sessionIdKey] = sessionId
		}
		return headers
	}
	
}

private extension Server {
	var baseURL: URL {
		return URL(string: "\(httpProtocol.rawValue)//:\(ip):\(port)")!
	}
}
