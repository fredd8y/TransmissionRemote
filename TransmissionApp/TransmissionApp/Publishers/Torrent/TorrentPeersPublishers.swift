//
//  TorrentPeersPublishers.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 22/08/23.
//

import OSLog
import Combine
import Foundation
import Transmission

enum TorrentPeersPublishers {
	
	static func makeTorrentPeersLoader(
		id: Int,
		server: Server
	) -> AnyPublisher<[TorrentPeer], Error> {
		return TransmissionHTTPClient.httpClient
			.postPublisher(
				url: APIsEndpoint.post.url(baseURL: server.baseURL),
				body: TorrentBodies.peers(id: id, fields: TorrentField.torrentPeers),
				additionalHeader: Headers.headers(server.credentials)
			)
			.tryMap(Logger.log)
			.tryMap(TorrentPeersMapper.map)
			.eraseToAnyPublisher()
	}
	
}
