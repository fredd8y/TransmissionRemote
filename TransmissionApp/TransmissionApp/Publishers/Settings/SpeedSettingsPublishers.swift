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
}
