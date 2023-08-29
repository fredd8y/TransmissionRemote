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
	
	static func makeNetworkSettingsGetPublisher(server: Server) -> AnyPublisher<NetworkSettings, Error> {
		return TransmissionHTTPClient.httpClient
			.postPublisher(
				url: APIsEndpoint.post.url(baseURL: server.baseURL),
				body: SessionBodies.get(fields: SessionField.networkSettings),
				additionalHeader: Headers.headers(server.credentials)
			)
			.tryMap(Logger.log)
			.tryMap(NetworkSettingsGetMapper.map)
			.eraseToAnyPublisher()
	}
	
	static func makePortTestPublisher(server: Server) -> AnyPublisher<Bool, Error> {
		return TransmissionHTTPClient.httpClient
			.postPublisher(
				url: APIsEndpoint.post.url(baseURL: server.baseURL),
				body: PortTestBodies.test,
				additionalHeader: Headers.headers(server.credentials)
			)
			.tryMap(Logger.log)
			.tryMap(PortTestMapper.map)
			.eraseToAnyPublisher()
	}
	
}
