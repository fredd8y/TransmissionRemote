//
//  ServerHandler.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 27/07/23.
//

import Combine
import Foundation
import Transmission

final class ServerHandler {
	
	private init() {}
	
	enum Error: Swift.Error {
		case openingError
	}
		
	static func makeServerLoader(atUrl url: URL) -> AnyPublisher<[Server], Swift.Error> {
		return Deferred {
			Future { completion in
				do {
					completion(.success(try TransmissionFileHandler.getContent(url)))
				} catch {
					completion(.failure(Error.openingError))
				}
			}
		}
		.eraseToAnyPublisher()
	}
	
}
