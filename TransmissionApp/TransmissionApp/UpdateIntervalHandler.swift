//
//  UpdateIntervalHandler.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 28/07/23.
//

import Combine
import Foundation
import Transmission

final class UpdateIntervalHandler {
	
	private init() {}
	
	static var updateIntervals = [2, 5, 10, 30]
	
	static func makeUpdateIntervalListLoader() -> AnyPublisher<[Int], Error> {
		Deferred {
			Future { completion in
				completion(.success(updateIntervals))
			}
		}.eraseToAnyPublisher()
	}
	
	static func makeCurrentUpdateIntervalLoader() -> AnyPublisher<Int, Error> {
		Deferred {
			Future { completion in
				completion(.success(UserDefaultsHandler.shared.updateInterval))
			}
		}.eraseToAnyPublisher()
	}
}
