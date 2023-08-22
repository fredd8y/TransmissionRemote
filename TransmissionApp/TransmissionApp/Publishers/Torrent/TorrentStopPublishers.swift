//
//  TorrentStopPublishers.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 22/08/23.
//

import OSLog
import Combine
import Foundation
import Transmission

enum TorrentStopPublishers {
	
	static func makeTorrentStopPublisher(
		server: Server,
		id: Int
	) -> AnyPublisher<Void, Error> {
		return TransmissionHTTPClient.httpClient
			.postPublisher(
				url: APIsEndpoint.post.url(baseURL: server.baseURL),
				body: TorrentBodies.stop(id: id),
				additionalHeader: Headers.headers(server.credentials)
			)
			.tryMap(Logger.log)
			.tryMap(TorrentStopMapper.map)
			.eraseToAnyPublisher()
	}
	
	static func makeTorrentStopAllPublisher(server: Server) -> AnyPublisher<Void, Error> {
		return TransmissionHTTPClient.httpClient
			.postPublisher(
				url: APIsEndpoint.post.url(baseURL: server.baseURL),
				body: TorrentBodies.stopAll(),
				additionalHeader: Headers.headers(server.credentials)
			)
			.tryMap(Logger.log)
			.tryMap(TorrentStopMapper.map)
			.eraseToAnyPublisher()
	}
	
}
