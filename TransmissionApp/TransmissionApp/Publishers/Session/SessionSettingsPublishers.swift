//
//  SessionSettingsPublishers.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 22/08/23.
//

import OSLog
import Combine
import Foundation
import Transmission

enum SessionSettingsPublishers {
		
	static func makeSetDownloadLimitEnabled(
		enabled: Bool,
		server: Server
	) -> AnyPublisher<Void, Error> {
		return TransmissionHTTPClient.httpClient
			.postPublisher(
				url: APIsEndpoint.post.url(baseURL: server.baseURL),
				body: SessionBodies.setDownloadLimit(enabled: enabled),
				additionalHeader: Headers.headers(server.credentials)
			)
			.mapError(NetworkErrorHandler.handleError)
			.tryMap(Logger.log)
			.tryMap(SessionSetMapper.map)
			.eraseToAnyPublisher()
	}
	
}

