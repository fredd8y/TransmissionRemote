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
				additionalHeader: headers(server.credentials)
			)
			.tryMap(Logger.log)
			.tryMap(TorrentStartMapper.map)
			.eraseToAnyPublisher()
	}
	
	static func makeTorrentStartAllPublisher(server: Server) -> AnyPublisher<Void, Error> {
		return httpClient
			.postPublisher(
				url: APIsEndpoint.post.url(baseURL: server.baseURL),
				body: TorrentBodies.startAll(),
				additionalHeader: headers(server.credentials)
			)
			.tryMap(Logger.log)
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
				additionalHeader: headers(server.credentials)
			)
			.tryMap(Logger.log)
			.tryMap(TorrentStopMapper.map)
			.eraseToAnyPublisher()
	}
	
	static func makeTorrentStopAllPublisher(server: Server) -> AnyPublisher<Void, Error> {
		return httpClient
			.postPublisher(
				url: APIsEndpoint.post.url(baseURL: server.baseURL),
				body: TorrentBodies.stopAll(),
				additionalHeader: headers(server.credentials)
			)
			.tryMap(Logger.log)
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
				additionalHeader: headers(server.credentials)
			)
			.tryMap(Logger.log)
			.tryMap(TorrentRemoveMapper.map)
			.eraseToAnyPublisher()
			
	}
	
	static func makeTorrentRemoveAllPublisher(
		server: Server,
		deleteLocalData: Bool
	) -> AnyPublisher<Void, Error> {
		return httpClient
			.postPublisher(
				url: APIsEndpoint.post.url(baseURL: server.baseURL),
				body: TorrentBodies.removeAll(deleteLocalData: deleteLocalData),
				additionalHeader: headers(server.credentials)
			)
			.tryMap(Logger.log)
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
				additionalHeader: headers(server.credentials)
			)
			.tryMap(Logger.log)
			.tryMap(SessionGetMapper.map)
			.tryMap { $0.downloadDir }
			.flatMap { downloadDir in
				Future { promise in
					do {
						httpClient.post(
							APIsEndpoint.post.url(baseURL: server.baseURL),
							body: try TorrentBodies.add(startWhenAdded: startWhenAdded, downloadDir: downloadDir, torrentFilePath: nil, filename: link),
							additionalHeader: headers(server.credentials)
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
	
	static func makeTorrentDetailLoader(
		id: Int,
		server: Server
	) -> AnyPublisher<TorrentDetail, Error> {
		return httpClient
			.postPublisher(
				url: APIsEndpoint.post.url(baseURL: server.baseURL),
				body: TorrentBodies.detail(id: id, fields: TorrentField.torrentDetailField),
				additionalHeader: headers(server.credentials)
			)
			.tryMap(Logger.log)
			.tryMap(TorrentDetailMapper.map)
			.eraseToAnyPublisher()
	}
	
	static func makeTorrentPeersLoader(
		id: Int,
		server: Server
	) -> AnyPublisher<[TorrentPeer], Error> {
		return httpClient
			.postPublisher(
				url: APIsEndpoint.post.url(baseURL: server.baseURL),
				body: TorrentBodies.peers(id: id, fields: TorrentField.torrentPeers),
				additionalHeader: headers(server.credentials)
			)
			.tryMap(Logger.log)
			.tryMap(TorrentPeersMapper.map)
			.eraseToAnyPublisher()
	}
	
	static func makeTorrentTrackersLoader(
		id: Int,
		server: Server
	) -> AnyPublisher<[TorrentTracker], Error> {
		return httpClient
			.postPublisher(
				url: APIsEndpoint.post.url(baseURL: server.baseURL),
				body: TorrentBodies.trackers(id: id, fields: TorrentField.torrentTrackers),
				additionalHeader: headers(server.credentials)
			)
			.tryMap(Logger.log)
			.tryMap(TorrentTrackersMapper.map)
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
				additionalHeader: headers(server.credentials)
			)
			.tryMap(Logger.log)
			.tryMap(SessionGetMapper.map)
			.tryMap { $0.downloadDir }
			.flatMap { downloadDir in
				Future { promise in
					do {
						httpClient.post(
							APIsEndpoint.post.url(baseURL: server.baseURL),
							body: try TorrentBodies.add(startWhenAdded: startWhenAdded, downloadDir: downloadDir, torrentFilePath: torrentFilePath, filename: nil),
							additionalHeader: headers(server.credentials)
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
	
	static func makeRemoteTorrentsLoader(server: Server) -> AnyPublisher<(Session, [Torrent]), Error> {
		var receivedSession: Session?
		return httpClient
			.postPublisher(
				url: APIsEndpoint.post.url(baseURL: server.baseURL),
				body: SessionBodies.get.data(using: .utf8)!,
				additionalHeader: headers(server.credentials)
			)
			.mapError(TransmissionHTTPClient.handleError)
			.tryMap(Logger.log)
			.tryMap(SessionGetMapper.map)
			.flatMap { session in
				Future { promise in
					receivedSession = session
					httpClient.post(
						APIsEndpoint.post.url(baseURL: server.baseURL),
						body: TorrentBodies.get(TorrentField.minimumTorrentField),
						additionalHeader: headers(server.credentials)
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
	
	static func makeSetDownloadLimitEnabled(
		enabled: Bool,
		server: Server
	) -> AnyPublisher<Void, Error> {
		return httpClient.postPublisher(
			url: APIsEndpoint.post.url(baseURL: server.baseURL),
			body: SessionBodies.setDownloadLimit(enabled: enabled),
			additionalHeader: headers(server.credentials)
		)
		.mapError(TransmissionHTTPClient.handleError)
		.tryMap(Logger.log)
		.tryMap(SessionSetMapper.map)
		.eraseToAnyPublisher()
	}
	
	static func handleError(_ error: Error) -> Error {
		guard (error as NSError).code == -1001 else {
			return SessionGetMapper.Error.invalidData
		}
		return SessionGetMapper.Error.serverTimeout
	}

	// MARK: Private

	private static let httpClient: HTTPClient = URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))

	private static func headers(_ credentials: (username: String, password: String)?) -> [String: String] {
		var headers: [String: String] = [:]
		if let credentials {
			headers[HeaderUtils.AUTHORIZATION_KEY] = HeaderUtils.basicAuthCredentialsString(username: credentials.username, password: credentials.password)
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
	
	var credentials: (username: String, password: String)? {
		if let username, let password {
			let decryptedPassword = try! Cipher.decryptPassword(
				password,
				withKey: try! Cipher.generateSymmetricKey(withPassword: try! Keychain.getPasswordKey())
			)
			return (username, decryptedPassword)
		} else {
			return nil
		}
	}
}
