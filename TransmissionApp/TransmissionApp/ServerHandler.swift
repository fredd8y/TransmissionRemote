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
	
	static func makeServerLoader() -> AnyPublisher<[Server], Error> {
		
		let serverFileURL = URL(string: "http://www.google.it")!
		
		return Deferred {
			Future { completion in
				do {
					completion(.success(try TransmissionFileHandler.getContent(serverFileURL)))
				} catch {
					completion(.failure(error))
				}
			}
		}.eraseToAnyPublisher()
	}
	
}
