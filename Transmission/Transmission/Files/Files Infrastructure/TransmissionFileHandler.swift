//
//  TransmissionFileHandler.swift
//  Transmission
//
//  Created by Federico Arvat on 27/07/23.
//

import Foundation

public class TransmissionFileHandler: FileHandler {
	
	public static func getContent<T>(_ url: URL) throws -> T where T : Decodable, T : Encodable {
		return try JSONDecoder().decode(T.self, from: try Data(contentsOf: url))
	}
	
}
