//
//  TransmissionHTTPClient.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 24/07/23.
//

import OSLog
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
			.tryMap(TransmissionHTTPClient.log)
			.eraseToAnyPublisher()
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
			.tryMap(TransmissionHTTPClient.log)
			.eraseToAnyPublisher()
			.tryMap(TorrentGetMapper.map)
			.eraseToAnyPublisher()
	}
	
	public static func log(_ data: Data, from response: HTTPURLResponse) throws -> (data: Data, response: HTTPURLResponse) {
		Logger.APIs.info("\nURL: \(response.url!)\nSTATUS-CODE: \(response.statusCode)\nRESPONSE: \(String(data: data, encoding: .utf8)!)")
		return (data, response)
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
		return URL(string: url)!
	}
}
