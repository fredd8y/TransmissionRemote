//
//  TorrentLoadPublishers.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 22/08/23.
//

import OSLog
import Combine
import Foundation
import Transmission

enum TorrentLoadPublishers {
	
	static func makeRemoteTorrentsLoader(server: Server) -> AnyPublisher<(Session, [Torrent]), Error> {
		var receivedSession: Session?
		return TransmissionHTTPClient.httpClient
			.postPublisher(
				url: APIsEndpoint.post.url(baseURL: server.baseURL),
				body: SessionBodies.get.data(using: .utf8)!,
				additionalHeader: Headers.headers(server.credentials)
			)
			.mapError(ErrorHandler.handleError)
			.tryMap(Logger.log)
			.tryMap(SessionGetMapper.map)
			.flatMap { session in
				Future { promise in
					receivedSession = session
					TransmissionHTTPClient.httpClient.post(
						APIsEndpoint.post.url(baseURL: server.baseURL),
						body: TorrentBodies.get(TorrentField.minimumTorrentField),
						additionalHeader: Headers.headers(server.credentials)
					) { result in
						promise(result)
					}
				}
			}
			.tryMap(Logger.log)
			.tryMap(TorrentGetMapper.map)
			.tryMap { torrents in
				guard let receivedSession else { throw SessionGetMapper.Error.invalidData }
				return (receivedSession, torrents)
			}
			.eraseToAnyPublisher()
	}
	
}
