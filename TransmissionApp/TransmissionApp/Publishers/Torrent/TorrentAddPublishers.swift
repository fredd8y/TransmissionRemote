//
//  TorrentAddPublishers.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 22/08/23.
//

import OSLog
import Combine
import Foundation
import Transmission

enum TorrentAddPublishers {
	
	static func makeLinkAddPublisher(
		server: Server,
		startWhenAdded: Bool,
		link: String
	) -> AnyPublisher<String, Error> {
		return TransmissionHTTPClient.httpClient
			.postPublisher(
				url: APIsEndpoint.post.url(baseURL: server.baseURL),
				body: SessionBodies.get.data(using: .utf8)!,
				additionalHeader: Headers.headers(server.credentials)
			)
			.tryMap(Logger.log)
			.tryMap(SessionGetMapper.map)
			.tryMap { $0.downloadDir }
			.flatMap { downloadDir in
				Future { promise in
					do {
						TransmissionHTTPClient.httpClient.post(
							APIsEndpoint.post.url(baseURL: server.baseURL),
							body: try TorrentBodies.add(startWhenAdded: startWhenAdded, downloadDir: downloadDir, torrentFilePath: nil, filename: link),
							additionalHeader: Headers.headers(server.credentials)
						) { result in
							promise(result)
						}
					} catch {
						promise(.failure(error))
					}
				}
			}
			.tryMap(Logger.log)
			.tryMap(TorrentAddMapper.map)
			.eraseToAnyPublisher()
	}
	
	static func makeTorrentAddPublisher(
		server: Server,
		startWhenAdded: Bool,
		torrentFilePath: String
	) -> AnyPublisher<String, Error> {
		return TransmissionHTTPClient.httpClient
			.postPublisher(
				url: APIsEndpoint.post.url(baseURL: server.baseURL),
				body: SessionBodies.get.data(using: .utf8)!,
				additionalHeader: Headers.headers(server.credentials)
			)
			.tryMap(Logger.log)
			.tryMap(SessionGetMapper.map)
			.tryMap { $0.downloadDir }
			.flatMap { downloadDir in
				Future { promise in
					do {
						TransmissionHTTPClient.httpClient.post(
							APIsEndpoint.post.url(baseURL: server.baseURL),
							body: try TorrentBodies.add(startWhenAdded: startWhenAdded, downloadDir: downloadDir, torrentFilePath: torrentFilePath, filename: nil),
							additionalHeader: Headers.headers(server.credentials)
						) { result in
							promise(result)
						}
					} catch {
						promise(.failure(error))
					}
				}
			}
			.tryMap(Logger.log)
			.tryMap(TorrentAddMapper.map)
			.eraseToAnyPublisher()
	}
	
}
