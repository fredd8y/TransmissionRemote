//
//  Combine+Publishers.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 24/07/23.
//

import Combine
import Foundation
import Transmission

public extension HTTPClient {
	typealias Publisher = AnyPublisher<(Data, HTTPURLResponse), Error>
	
	func postPublisher(url: URL, body: Data, additionalHeader: [String: String]? = nil) -> Publisher {
		return Deferred {
			Future { completion in
				self.post(url, body: body, additionalHeader: additionalHeader, completion: completion)
			}
		}.eraseToAnyPublisher()
	}
}
