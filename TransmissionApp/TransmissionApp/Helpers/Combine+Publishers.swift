//
//  Combine+Publishers.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 24/07/23.
//

import OSLog
import Combine
import Foundation
import Transmission

public extension HTTPClient {
	typealias Publisher = AnyPublisher<(Data, HTTPURLResponse), Error>
	
	func postPublisher(url: URL, body: Data, additionalHeader: [String: String]? = nil) -> Publisher {
		return Deferred {
			Future { completion in
				let headers = additionalHeader?.reduce("", { partialResult, header in
					partialResult + "\n-  \(header.0): \(header.1)"
				}) ?? "EMPTY-HEADERS"
				Logger.APIs.info("\nURL: \(url)\nBODY: \(String(data: body, encoding: .utf8)!)\nHEADERS:\(headers)")
				self.post(url, body: body, additionalHeader: additionalHeader, completion: completion)
			}
		}.eraseToAnyPublisher()
	}
}

extension Publisher where Self == HTTPClient.Publisher {
	func logResponse() -> HTTPClient.Publisher {
		handleEvents(
			receiveOutput: { (data, response) in
				Logger.APIs.info("\nURL: \(response.url!)\nSTATUS-CODE: \(response.statusCode)\nRESPONSE: \(String(data: data, encoding: .utf8)!)")
			},
			receiveCompletion: { completion in
				switch completion {
				case .finished: break
				case .failure(let error):
					Logger.APIs.error("\nERROR: \(error.localizedDescription)")
				}
			}
		).eraseToAnyPublisher()
	}
}
