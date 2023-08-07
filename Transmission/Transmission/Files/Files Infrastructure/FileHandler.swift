//
//  FileHandler.swift
//  Transmission
//
//  Created by Federico Arvat on 27/07/23.
//

import Foundation

public protocol FileHandler {
			
	static func getContent<T>(_ url: URL) throws -> T? where T : Decodable
	
	static func setContent<T>(_ url: URL, content: T) throws  where T : Encodable
	
}