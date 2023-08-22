//
//  TorrentRemovePublishers.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 22/08/23.
//

import OSLog
import Combine
import Foundation
import Transmission

enum TorrentRemovePublishers {
	
	static func makeTorrentRemovePublisher(
		server: Server,
		id: Int,
		deleteLocalData: Bool
	) -> AnyPublisher<Void, Error> {
		return TransmissionHTTPClient.httpClient
			.postPublisher(
				url: APIsEndpoint.post.url(baseURL: server.baseURL),
				body: TorrentBodies.remove(id: id, deleteLocalData: deleteLocalData),
				additionalHeader: Headers.headers(server.credentials)
			)
			.tryMap(Logger.log)
			.tryMap(TorrentRemoveMapper.map)
			.eraseToAnyPublisher()
		
	}
	
	static func makeTorrentRemoveAllPublisher(
		server: Server,
		deleteLocalData: Bool
	) -> AnyPublisher<Void, Error> {
		return TransmissionHTTPClient.httpClient
			.postPublisher(
				url: APIsEndpoint.post.url(baseURL: server.baseURL),
				body: TorrentBodies.removeAll(deleteLocalData: deleteLocalData),
				additionalHeader: Headers.headers(server.credentials)
			)
			.tryMap(Logger.log)
			.tryMap(TorrentRemoveMapper.map)
			.eraseToAnyPublisher()
	}
	
}

