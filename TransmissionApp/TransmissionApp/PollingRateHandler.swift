//
//  PollingRateHandler.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 28/07/23.
//

import Combine
import Foundation
import Transmission

final class PollingRateHandler {
	
	private init() {}
	
	static var pollingRateList = [2, 5, 10, 30]
	
	static func makeUpdatePollingRateLoader() -> AnyPublisher<[Int], Error> {
		Deferred {
			Future { completion in
				completion(.success(pollingRateList))
			}
		}.eraseToAnyPublisher()
	}
	
	static func makeCurrentPollingRateLoader() -> AnyPublisher<Int, Error> {
		Deferred {
			Future { completion in
				completion(.success(UserDefaultsHandler.shared.pollingRate))
			}
		}.eraseToAnyPublisher()
	}
}
