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
	static var username: String?
	static var password: String?

	static func makeRemoteSessionLoader() -> AnyPublisher<Session, Error> {
		return httpClient
			.postPublisher(
				url: APIsEndpoint.post.url(baseURL: URL(string: "http://192.168.178.39:9091")!),
				body: SessionBodies.get.data(using: .utf8)!,
				additionalHeader: headers()
			)
			.logResponse()
			.tryMap(SessionGetMapper.map)
			.eraseToAnyPublisher()
	}

	static func makeRemoteTorrentsLoader() -> AnyPublisher<[Torrent], Error> {
		return httpClient
			.postPublisher(
				url: APIsEndpoint.post.url(baseURL: URL(string: "http://192.168.178.39:9091")!),
				body: TorrentBodies.get(TorrentField.minimumTorrentField),
				additionalHeader: headers()
			)
			.logResponse()
			.tryMap(TorrentGetMapper.map)
			.eraseToAnyPublisher()
	}

	// MARK: Private

	private static let httpClient: HTTPClient = URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))

	private static func headers() -> [String: String] {
		var headers: [String: String] = [:]
		if let username, let password {
			headers[HeaderUtils.AUTHORIZATION_KEY] = HeaderUtils.basicAuthCredentialsString(username: username, password: password)
		}
		if let sessionId {
			headers[SessionGetMapper.sessionIdKey] = sessionId
		}
		return headers
	}
	
}
