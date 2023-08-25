//
//  SpeedSettingsPublishers.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 25/08/23.
//

import OSLog
import Combine
import Foundation
import Transmission

enum SpeedSettingsPublishers {
	static func makeSpeedSettingsGetPublisher(server: Server) -> AnyPublisher<SpeedSettings, Error> {
		return TransmissionHTTPClient.httpClient
			.postPublisher(
				url: APIsEndpoint.post.url(baseURL: server.baseURL),
				body: SessionBodies.get(fields: SessionField.speedSettings),
				additionalHeader: Headers.headers(server.credentials)
			)
			.tryMap(Logger.log)
			.tryMap(SpeedSettingsGetMapper.map)
			.eraseToAnyPublisher()
	}
	
	static func makeUploadLimitEnabledPublisher(
		enabled: Bool,
		server: Server
	) -> AnyPublisher<Void, Error> {
		return TransmissionHTTPClient.httpClient
			.postPublisher(
				url: APIsEndpoint.post.url(baseURL: server.baseURL),
				body: SessionBodies.setUploadLimitEnabled(enabled: enabled),
				additionalHeader: Headers.headers(server.credentials)
			)
			.tryMap(Logger.log)
			.tryMap(SessionSetMapper.map)
			.eraseToAnyPublisher()
	}
	
	static func makeDownloadLimitEnabledPublisher(
		enabled: Bool,
		server: Server
	) -> AnyPublisher<Void, Error> {
		return TransmissionHTTPClient.httpClient
			.postPublisher(
				url: APIsEndpoint.post.url(baseURL: server.baseURL),
				body: SessionBodies.setDownloadLimitEnabled(enabled: enabled),
				additionalHeader: Headers.headers(server.credentials)
			)
			.tryMap(Logger.log)
			.tryMap(SessionSetMapper.map)
			.eraseToAnyPublisher()
	}
	
	static func makeScheduledTimesEnabledPublisher(
		enabled: Bool,
		server: Server
	) -> AnyPublisher<Void, Error> {
		return TransmissionHTTPClient.httpClient
			.postPublisher(
				url: APIsEndpoint.post.url(baseURL: server.baseURL),
				body: SessionBodies.setAltSpeedTimeEnabled(enabled: enabled),
				additionalHeader: Headers.headers(server.credentials)
			)
			.tryMap(Logger.log)
			.tryMap(SessionSetMapper.map)
			.eraseToAnyPublisher()
	}
	
	static func makeUploadLimitPublisher(
		limit: Int,
		server: Server
	) -> AnyPublisher<Void, Error> {
		return TransmissionHTTPClient.httpClient
			.postPublisher(
				url: APIsEndpoint.post.url(baseURL: server.baseURL),
				body: SessionBodies.setSpeedLimitUp(limit: limit),
				additionalHeader: Headers.headers(server.credentials)
			)
			.tryMap(Logger.log)
			.tryMap(SessionSetMapper.map)
			.eraseToAnyPublisher()
	}
	
	static func makeDownloadLimitPublisher(
		limit: Int,
		server: Server
	) -> AnyPublisher<Void, Error> {
		return TransmissionHTTPClient.httpClient
			.postPublisher(
				url: APIsEndpoint.post.url(baseURL: server.baseURL),
				body: SessionBodies.setSpeedLimitDown(limit: limit),
				additionalHeader: Headers.headers(server.credentials)
			)
			.tryMap(Logger.log)
			.tryMap(SessionSetMapper.map)
			.eraseToAnyPublisher()
	}
	
	static func makeAlternativeUploadLimitPublisher(
		limit: Int,
		server: Server
	) -> AnyPublisher<Void, Error> {
		return TransmissionHTTPClient.httpClient
			.postPublisher(
				url: APIsEndpoint.post.url(baseURL: server.baseURL),
				body: SessionBodies.setAltSpeedUp(limit: limit),
				additionalHeader: Headers.headers(server.credentials)
			)
			.tryMap(Logger.log)
			.tryMap(SessionSetMapper.map)
			.eraseToAnyPublisher()
	}
	
	static func makeAlternativeDownloadLimitPublisher(
		limit: Int,
		server: Server
	) -> AnyPublisher<Void, Error> {
		return TransmissionHTTPClient.httpClient
			.postPublisher(
				url: APIsEndpoint.post.url(baseURL: server.baseURL),
				body: SessionBodies.setAltSpeedDown(limit: limit),
				additionalHeader: Headers.headers(server.credentials)
			)
			.tryMap(Logger.log)
			.tryMap(SessionSetMapper.map)
			.eraseToAnyPublisher()
	}
}
