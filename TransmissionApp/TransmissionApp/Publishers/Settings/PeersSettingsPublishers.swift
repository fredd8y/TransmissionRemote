//
//  PeersSettingsPublishers.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 28/08/23.
//

import OSLog
import Combine
import Foundation
import Transmission

enum PeersSettingsPublishers {
	static func makePeersSettingsGetPublisher(server: Server) -> AnyPublisher<PeersSettings, Error> {
		return TransmissionHTTPClient.httpClient
			.postPublisher(
				url: APIsEndpoint.post.url(baseURL: server.baseURL),
				body: SessionBodies.get(fields: SessionField.peersSettings),
				additionalHeader: Headers.headers(server.credentials)
			)
			.tryMap(Logger.log)
			.tryMap(PeersSettingsGetMapper.map)
			.eraseToAnyPublisher()
	}
	
	static func makeEncryptionSetPublisher(
		value: String,
		server: Server
	) -> AnyPublisher<Void, Error> {
		return TransmissionHTTPClient.httpClient
			.postPublisher(
				url: APIsEndpoint.post.url(baseURL: server.baseURL),
				body: SessionBodies.setPeersEncryption(value: value),
				additionalHeader: Headers.headers(server.credentials)
			)
			.tryMap(Logger.log)
			.tryMap(SessionSetMapper.map)
			.eraseToAnyPublisher()
	}
	
	static func makePexEnabledSetPublisher(
		enabled: Bool,
		server: Server
	) -> AnyPublisher<Void, Error> {
		return TransmissionHTTPClient.httpClient
			.postPublisher(
				url: APIsEndpoint.post.url(baseURL: server.baseURL),
				body: SessionBodies.setPexEnabled(enabled: enabled),
				additionalHeader: Headers.headers(server.credentials)
			)
			.tryMap(Logger.log)
			.tryMap(SessionSetMapper.map)
			.eraseToAnyPublisher()
	}
	
	static func makeDhtEnabledSetPublisher(
		enabled: Bool,
		server: Server
	) -> AnyPublisher<Void, Error> {
		return TransmissionHTTPClient.httpClient
			.postPublisher(
				url: APIsEndpoint.post.url(baseURL: server.baseURL),
				body: SessionBodies.setDhtEnabled(enabled: enabled),
				additionalHeader: Headers.headers(server.credentials)
			)
			.tryMap(Logger.log)
			.tryMap(SessionSetMapper.map)
			.eraseToAnyPublisher()
	}
	
	static func makeLpdEnabledSetPublisher(
		enabled: Bool,
		server: Server
	) -> AnyPublisher<Void, Error> {
		return TransmissionHTTPClient.httpClient
			.postPublisher(
				url: APIsEndpoint.post.url(baseURL: server.baseURL),
				body: SessionBodies.setLpdEnabled(enabled: enabled),
				additionalHeader: Headers.headers(server.credentials)
			)
			.tryMap(Logger.log)
			.tryMap(SessionSetMapper.map)
			.eraseToAnyPublisher()
	}
	
	static func makeBlocklistEnabledSetPublisher(
		enabled: Bool,
		server: Server
	) -> AnyPublisher<Void, Error> {
		return TransmissionHTTPClient.httpClient
			.postPublisher(
				url: APIsEndpoint.post.url(baseURL: server.baseURL),
				body: SessionBodies.setBlocklistEnabled(enabled: enabled),
				additionalHeader: Headers.headers(server.credentials)
			)
			.tryMap(Logger.log)
			.tryMap(SessionSetMapper.map)
			.eraseToAnyPublisher()
	}
	
	static func makeGlobalPeerLimitSetPublisher(
		limit: Int,
		server: Server
	) -> AnyPublisher<Void, Error> {
		return TransmissionHTTPClient.httpClient
			.postPublisher(
				url: APIsEndpoint.post.url(baseURL: server.baseURL),
				body: SessionBodies.setGlobalPeerLimit(limit: limit),
				additionalHeader: Headers.headers(server.credentials)
			)
			.tryMap(Logger.log)
			.tryMap(SessionSetMapper.map)
			.eraseToAnyPublisher()
	}
	
	static func makePeerLimitPerTorrentSetPublisher(
		limit: Int,
		server: Server
	) -> AnyPublisher<Void, Error> {
		return TransmissionHTTPClient.httpClient
			.postPublisher(
				url: APIsEndpoint.post.url(baseURL: server.baseURL),
				body: SessionBodies.setPeerLimitPerTorrent(limit: limit),
				additionalHeader: Headers.headers(server.credentials)
			)
			.tryMap(Logger.log)
			.tryMap(SessionSetMapper.map)
			.eraseToAnyPublisher()
	}
	
	static func makeBlocklistUrlSetPublisher(
		url: String,
		server: Server
	) -> AnyPublisher<Void, Error> {
		return TransmissionHTTPClient.httpClient
			.postPublisher(
				url: APIsEndpoint.post.url(baseURL: server.baseURL),
				body: SessionBodies.setBlocklistUrl(url: url),
				additionalHeader: Headers.headers(server.credentials)
			)
			.tryMap(Logger.log)
			.tryMap(SessionSetMapper.map)
			.eraseToAnyPublisher()
	}
}
