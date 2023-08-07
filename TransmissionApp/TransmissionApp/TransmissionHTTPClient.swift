//
//  TransmissionHTTPClient.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 24/07/23.
//

import OSLog
import Combine
import Foundation
import Transmission

final class TransmissionHTTPClient {
	
	private init() {}
	
	static var sessionId: String?

	static func makeTorrentStartPublisher(
		server: Server,
		id: Int
	) -> AnyPublisher<Void, Error> {
		return httpClient
			.postPublisher(
				url: APIsEndpoint.post.url(baseURL: server.baseURL),
				body: TorrentBodies.start(id: id),
				additionalHeader: headers(server)
			)
			.tryMap(TransmissionHTTPClient.log)
			.tryMap(TorrentStartMapper.map)
			.eraseToAnyPublisher()
	}
	static func makeTorrentStopPublisher(
		server: Server,
		id: Int
	) -> AnyPublisher<Void, Error> {
		return httpClient
			.postPublisher(
				url: APIsEndpoint.post.url(baseURL: server.baseURL),
				body: TorrentBodies.stop(id: id),
				additionalHeader: headers(server)
			)
			.tryMap(TransmissionHTTPClient.log)
			.tryMap(TorrentStopMapper.map)
			.eraseToAnyPublisher()
	}
	
	static func makeTorrentRemovePublisher(
		server: Server,
		id: Int,
		deleteLocalData: Bool
	) -> AnyPublisher<Void, Error> {
		return httpClient
			.postPublisher(
				url: APIsEndpoint.post.url(baseURL: server.baseURL),
				body: TorrentBodies.remove(id: id, deleteLocalData: deleteLocalData),
				additionalHeader: headers(server)
			)
			.tryMap(TransmissionHTTPClient.log)
			.tryMap(TorrentRemoveMapper.map)
			.eraseToAnyPublisher()
			
	}
	
	static func makeLinkAddPublisher(
		server: Server,
		startWhenAdded: Bool,
		link: String
	) -> AnyPublisher<String, Error> {
		return httpClient
			.postPublisher(
				url: APIsEndpoint.post.url(baseURL: server.baseURL),
				body: SessionBodies.get.data(using: .utf8)!,
				additionalHeader: headers(server)
			)
			.tryMap(TransmissionHTTPClient.log)
			.tryMap(SessionGetMapper.map)
			.tryMap { $0.downloadDir }
			.flatMap { downloadDir in
				Future { promise in
					do {
						httpClient.post(
							APIsEndpoint.post.url(baseURL: server.baseURL),
							body: try TorrentBodies.add(startWhenAdded: startWhenAdded, downloadDir: downloadDir, torrentFilePath: nil, filename: link),
							additionalHeader: headers(server)
						) { result in
							promise(result)
						}
					} catch {
						promise(.failure(error))
					}
				}
			}
			.tryMap(TransmissionHTTPClient.log)
			.tryMap(TorrentAddMapper.map)
			.eraseToAnyPublisher()
	}
	
	static func makeTorrentAddPublisher(
		server: Server,
		startWhenAdded: Bool,
		torrentFilePath: String
	) -> AnyPublisher<String, Error> {
		return httpClient
			.postPublisher(
				url: APIsEndpoint.post.url(baseURL: server.baseURL),
				body: SessionBodies.get.data(using: .utf8)!,
				additionalHeader: headers(server)
			)
			.tryMap(TransmissionHTTPClient.log)
			.tryMap(SessionGetMapper.map)
			.tryMap { $0.downloadDir }
			.flatMap { downloadDir in
				Future { promise in
					do {
						httpClient.post(
							APIsEndpoint.post.url(baseURL: server.baseURL),
							body: try TorrentBodies.add(startWhenAdded: startWhenAdded, downloadDir: downloadDir, torrentFilePath: torrentFilePath, filename: nil),
							additionalHeader: headers(server)
						) { result in
							promise(result)
						}
					} catch {
						promise(.failure(error))
					}
				}
			}
			.tryMap(TransmissionHTTPClient.log)
			.tryMap(TorrentAddMapper.map)
			.eraseToAnyPublisher()
	}
	
	static func makeRemoteTorrentsLoader(server: Server) -> AnyPublisher<[Torrent], Error> {
		return httpClient
			.postPublisher(
				url: APIsEndpoint.post.url(baseURL: server.baseURL),
				body: SessionBodies.get.data(using: .utf8)!,
				additionalHeader: headers(server)
			)
			.tryMap(TransmissionHTTPClient.log)
			.tryMap(SessionGetMapper.map)
			.flatMap { _ in
				Future { promise in
					httpClient.post(
						APIsEndpoint.post.url(baseURL: server.baseURL),
						body: TorrentBodies.get(TorrentField.minimumTorrentField),
						additionalHeader: headers(server)
					) { result in
						promise(result)
					}
				}
			}
			.tryMap(TransmissionHTTPClient.log)
			.tryMap(TorrentGetMapper.map)
			.eraseToAnyPublisher()
	}
	
	public static func log(_ data: Data, from response: HTTPURLResponse) throws -> (data: Data, response: HTTPURLResponse) {
		Logger.APIs.info("\nURL: \(response.url!)\nSTATUS-CODE: \(response.statusCode)\nRESPONSE: \(String(data: data, encoding: .utf8)!)")
		return (data, response)
	}

	// MARK: Private

	private static let httpClient: HTTPClient = URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))

	private static func headers(_ server: Server) -> [String: String] {
		var headers: [String: String] = [:]
		if let username = server.username, let password = server.password {
			headers[HeaderUtils.AUTHORIZATION_KEY] = HeaderUtils.basicAuthCredentialsString(username: username, password: password)
		}
		if let sessionId {
			headers[SessionGetMapper.sessionIdKey] = sessionId
		}
		return headers
	}
	
}

private extension Server {
	var baseURL: URL {
		return URL(string: url)!
	}
}
