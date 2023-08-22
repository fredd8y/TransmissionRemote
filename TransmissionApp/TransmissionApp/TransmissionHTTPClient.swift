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

enum TransmissionHTTPClient {
	
	static var sessionId: String?

	static let httpClient: HTTPClient = URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
	
}
