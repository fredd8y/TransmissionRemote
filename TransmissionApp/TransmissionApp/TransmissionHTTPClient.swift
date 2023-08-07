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
	
	private static let httpClient: HTTPClient = {
		URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
	}()
	
	static func makeRemoteSessionLoader() -> () -> AnyPublisher<Session, Error> {
		return { [httpClient] in
			return httpClient
				.postPublisher(
					url: APIsEndpoint.post.url(baseURL: URL(string: "http://192.168.178.39:9091")!),
					body: SessionBodies.get.data(using: .utf8)!
				)
				.tryMap(SessionGetMapper.map)
				.eraseToAnyPublisher()
		}
	}
	
	static func makeRemoteTorrentsLoader() -> () -> AnyPublisher<[Torrent], Error> {
		return { [httpClient] in
			return httpClient
				.postPublisher(
					url: APIsEndpoint.post.url(baseURL: URL(string: "http://192.168.178.39:9091")!),
					body: TorrentBodies.get.data(using: .utf8)!
				)
				.tryMap(TorrentGetMapper.map)
				.eraseToAnyPublisher()
		}
	}
	
}
