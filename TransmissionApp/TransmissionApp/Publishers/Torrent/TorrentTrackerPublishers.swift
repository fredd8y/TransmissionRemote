//
//  TorrentTrackerPublishers.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 22/08/23.
//

import OSLog
import Combine
import Foundation
import Transmission

enum TorrentTrackerPublishers {
		
	static func makeTorrentTrackersLoader(
		id: Int,
		server: Server
	) -> AnyPublisher<[TorrentTracker], Error> {
		return TransmissionHTTPClient.httpClient
			.postPublisher(
				url: APIsEndpoint.post.url(baseURL: server.baseURL),
				body: TorrentBodies.get(id: id, fields: TorrentField.torrentTrackers),
				additionalHeader: Headers.headers(server.credentials)
			)
			.tryMap(Logger.log)
			.tryMap(TorrentTrackersMapper.map)
			.eraseToAnyPublisher()
	}
	
}
