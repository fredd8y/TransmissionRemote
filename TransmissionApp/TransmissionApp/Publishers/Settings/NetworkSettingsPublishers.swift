//
//  NetworkSettingsPublishers.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 29/08/23.
//

import OSLog
import Combine
import Foundation
import Transmission

enum NetworkSettingsPublishers {
	
	static func makeNetworkSettingsGetPublisher(server: Server) -> AnyPublisher<(NetworkSettings, Bool), Error> {
		var receivedNetworkSettings: NetworkSettings?
		return TransmissionHTTPClient.httpClient
			.postPublisher(
				url: APIsEndpoint.post.url(baseURL: server.baseURL),
				body: SessionBodies.get(fields: SessionField.networkSettings),
				additionalHeader: Headers.headers(server.credentials)
			)
			.mapError(NetworkErrorHandler.handleError)
			.tryMap(Logger.log)
			.tryMap(AuthenticationMapper.map)
			.tryMap(Logger.log)
			.tryMap(NetworkSettingsGetMapper.map)
			.flatMap { networkSettings in
				Future { promise in
					receivedNetworkSettings = networkSettings
					TransmissionHTTPClient.httpClient.post(
						APIsEndpoint.post.url(baseURL: server.baseURL),
						body: PortTestBodies.test,
						additionalHeader: Headers.headers(server.credentials)
					) { result in
						promise(result)
					}
				}
			}
			.tryMap(Logger.log)
			.tryMap(PortTestMapper.map)
			.tryMap { portStatus in
				guard let receivedNetworkSettings else { throw PortTestMapper.Error.invalidData }
				return (receivedNetworkSettings, portStatus)
			}
			.eraseToAnyPublisher()
	}
	
	static func makePortRandomOnStartChangePublisher(
		enabled: Bool,
		server: Server
	) -> AnyPublisher<Void, Error> {
		return TransmissionHTTPClient.httpClient
			.postPublisher(
				url: APIsEndpoint.post.url(baseURL: server.baseURL),
				body: SessionBodies.setPortRandomOnStart(enabled: enabled),
				additionalHeader: Headers.headers(server.credentials)
			)
			.tryMap(Logger.log)
			.tryMap(SessionSetMapper.map)
			.eraseToAnyPublisher()
	}
	
	static func makePortForwardingChangePublisher(
		enabled: Bool,
		server: Server
	) -> AnyPublisher<Void, Error> {
		return TransmissionHTTPClient.httpClient
			.postPublisher(
				url: APIsEndpoint.post.url(baseURL: server.baseURL),
				body: SessionBodies.setPortForwarding(enabled: enabled),
				additionalHeader: Headers.headers(server.credentials)
			)
			.tryMap(Logger.log)
			.tryMap(SessionSetMapper.map)
			.eraseToAnyPublisher()
	}
	
	static func makeUtpEnabledChangePublisher(
		enabled: Bool,
		server: Server
	) -> AnyPublisher<Void, Error> {
		return TransmissionHTTPClient.httpClient
			.postPublisher(
				url: APIsEndpoint.post.url(baseURL: server.baseURL),
				body: SessionBodies.setUtpEnabled(enabled: enabled),
				additionalHeader: Headers.headers(server.credentials)
			)
			.tryMap(Logger.log)
			.tryMap(SessionSetMapper.map)
			.eraseToAnyPublisher()
	}
	
	static func makeListeningPortChangePublisher(
		port: Int,
		server: Server
	) -> AnyPublisher<Void, Error> {
		return TransmissionHTTPClient.httpClient
			.postPublisher(
				url: APIsEndpoint.post.url(baseURL: server.baseURL),
				body: SessionBodies.setListeningPort(port: port),
				additionalHeader: Headers.headers(server.credentials)
			)
			.tryMap(Logger.log)
			.tryMap(SessionSetMapper.map)
			.eraseToAnyPublisher()
	}
	
}
