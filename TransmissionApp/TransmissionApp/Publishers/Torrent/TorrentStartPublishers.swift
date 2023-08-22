//
//  TorrentStartPublishers.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 22/08/23.
//

import OSLog
import Combine
import Foundation
import Transmission

enum TorrentStartPublishers {
		
	static func makeTorrentStartPublisher(
		server: Server,
		id: Int
	) -> AnyPublisher<Void, Error> {
		return TransmissionHTTPClient.httpClient
			.postPublisher(
				url: APIsEndpoint.post.url(baseURL: server.baseURL),
				body: TorrentBodies.start(id: id),
				additionalHeader: Headers.headers(server.credentials)
			)
			.tryMap(Logger.log)
			.tryMap(TorrentStartMapper.map)
			.eraseToAnyPublisher()
	}
	
	static func makeTorrentStartAllPublisher(server: Server) -> AnyPublisher<Void, Error> {
		return TransmissionHTTPClient.httpClient
			.postPublisher(
				url: APIsEndpoint.post.url(baseURL: server.baseURL),
				body: TorrentBodies.startAll(),
				additionalHeader: Headers.headers(server.credentials)
			)
			.tryMap(Logger.log)
			.tryMap(TorrentStartMapper.map)
			.eraseToAnyPublisher()
	}
	
}
