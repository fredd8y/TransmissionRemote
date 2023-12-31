//
//  ServerPublishers.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 27/07/23.
//

import Combine
import Foundation
import Transmission

enum ServerPublishers {
		
	enum Error: Swift.Error {
		case readError
		case writeError
	}
		
	static func makeServerGetLoader(atUrl url: URL) -> AnyPublisher<[Server], Swift.Error> {
		getDataPublisher(url)
		.tryMap(ServerGetMapper.map)
		.eraseToAnyPublisher()
	}
	
	private static func getDataPublisher(_ url: URL) -> AnyPublisher<Data, Swift.Error> {
		Deferred {
			Future { completion in
				do {
					completion(.success(try Data(contentsOf: url)))
				} catch {
					completion(.failure(Error.readError))
				}
			}
		}.eraseToAnyPublisher()
	}
	
}

