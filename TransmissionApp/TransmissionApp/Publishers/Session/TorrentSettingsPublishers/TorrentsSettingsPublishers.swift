//
//  TorrentsSettingsPublishers.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 22/08/23.
//

import OSLog
import Combine
import Foundation
import Transmission

enum TorrentsSettingsPublishers {
	
	static func makeTorrentsSettingsGetPublisher(server: Server) -> AnyPublisher<TorrentsSettings, Error> {
		return TransmissionHTTPClient.httpClient
			.postPublisher(
				url: APIsEndpoint.post.url(baseURL: server.baseURL),
				body: SessionBodies.get(fields: SessionField.torrentsSettings),
				additionalHeader: Headers.headers(server.credentials)
			)
			.tryMap(Logger.log)
			.tryMap(TorrentsSettingsGetMapper.map)
			.eraseToAnyPublisher()
	}
	
	static func makeDownloadDirSetPublisher(
		downloadDir: String,
		server: Server
	) -> AnyPublisher<Void, Error> {
		return TransmissionHTTPClient.httpClient
			.postPublisher(
				url: APIsEndpoint.post.url(baseURL: server.baseURL),
				body: SessionBodies.setDownloadDir(downloadDir: downloadDir),
				additionalHeader: Headers.headers(server.credentials)
			)
			.mapError(ErrorHandler.handleError)
			.tryMap(Logger.log)
			.tryMap(SessionSetMapper.map)
			.eraseToAnyPublisher()
	}
	
	static func makeStartAddedTorrentSetPublisher(
		enabled: Bool,
		server: Server
	) -> AnyPublisher<Void, Error> {
		return TransmissionHTTPClient.httpClient
			.postPublisher(
				url: APIsEndpoint.post.url(baseURL: server.baseURL),
				body: SessionBodies.setStartAddedTorrents(enabled: enabled),
				additionalHeader: Headers.headers(server.credentials)
			)
			.mapError(ErrorHandler.handleError)
			.tryMap(Logger.log)
			.tryMap(SessionSetMapper.map)
			.eraseToAnyPublisher()
	}
	
	static func makeRenamePartialFilesSetPublisher(
		enabled: Bool,
		server: Server
	) -> AnyPublisher<Void, Error> {
		return TransmissionHTTPClient.httpClient
			.postPublisher(
				url: APIsEndpoint.post.url(baseURL: server.baseURL),
				body: SessionBodies.setRenamePartialFiles(enabled: enabled),
				additionalHeader: Headers.headers(server.credentials)
			)
			.mapError(ErrorHandler.handleError)
			.tryMap(Logger.log)
			.tryMap(SessionSetMapper.map)
			.eraseToAnyPublisher()
	}
	
	static func makeSeedRatioLimitedSetPublisher(
		enabled: Bool,
		server: Server
	) -> AnyPublisher<Void, Error> {
		return TransmissionHTTPClient.httpClient
			.postPublisher(
				url: APIsEndpoint.post.url(baseURL: server.baseURL),
				body: SessionBodies.setSeedRatioLimited(enabled: enabled),
				additionalHeader: Headers.headers(server.credentials)
			)
			.mapError(ErrorHandler.handleError)
			.tryMap(Logger.log)
			.tryMap(SessionSetMapper.map)
			.eraseToAnyPublisher()
	}
	
	static func makeSeedRatioLimitSetPublisher(
		limit: Int,
		server: Server
	) -> AnyPublisher<Void, Error> {
		return TransmissionHTTPClient.httpClient
			.postPublisher(
				url: APIsEndpoint.post.url(baseURL: server.baseURL),
				body: SessionBodies.setSeedRatioLimit(limit: limit),
				additionalHeader: Headers.headers(server.credentials)
			)
			.mapError(ErrorHandler.handleError)
			.tryMap(Logger.log)
			.tryMap(SessionSetMapper.map)
			.eraseToAnyPublisher()
	}
	
	static func makeIdleSeedingLimitEnabledSetPublisher(
		enabled: Bool,
		server: Server
	) -> AnyPublisher<Void, Error> {
		return TransmissionHTTPClient.httpClient
			.postPublisher(
				url: APIsEndpoint.post.url(baseURL: server.baseURL),
				body: SessionBodies.setIdleSeedingLimitEnabled(enabled: enabled),
				additionalHeader: Headers.headers(server.credentials)
			)
			.mapError(ErrorHandler.handleError)
			.tryMap(Logger.log)
			.tryMap(SessionSetMapper.map)
			.eraseToAnyPublisher()
	}
	
	static func makeIdleSeedingLimitSetPublisher(
		limit: Int,
		server: Server
	) -> AnyPublisher<Void, Error> {
		return TransmissionHTTPClient.httpClient
			.postPublisher(
				url: APIsEndpoint.post.url(baseURL: server.baseURL),
				body: SessionBodies.setIdleSeedingLimit(limit: limit),
				additionalHeader: Headers.headers(server.credentials)
			)
			.mapError(ErrorHandler.handleError)
			.tryMap(Logger.log)
			.tryMap(SessionSetMapper.map)
			.eraseToAnyPublisher()
	}
	
}
