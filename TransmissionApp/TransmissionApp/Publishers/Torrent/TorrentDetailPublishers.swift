//
//  TorrentDetailPublishers.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 22/08/23.
//

import OSLog
import Combine
import Foundation
import Transmission

enum TorrentDetailPublishers {
	
	static func makeTorrentDetailLoader(
		id: Int,
		server: Server
	) -> AnyPublisher<TorrentDetail, Error> {
		return TransmissionHTTPClient.httpClient
			.postPublisher(
				url: APIsEndpoint.post.url(baseURL: server.baseURL),
				body: TorrentBodies.get(id: id, fields: TorrentField.torrentDetailField),
				additionalHeader: Headers.headers(server.credentials)
			)
			.tryMap(Logger.log)
			.tryMap(TorrentDetailMapper.map)
			.eraseToAnyPublisher()
	}
	
}
