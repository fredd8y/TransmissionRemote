//
//  Logger+.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 26/07/23.
//

import OSLog

extension Logger {
	private static var subsystem = Bundle.main.bundleIdentifier!
	
	static let APIs = Logger(subsystem: subsystem, category: "APIs")
	
	static func log(_ data: Data, from response: HTTPURLResponse) throws -> (data: Data, response: HTTPURLResponse) {
		Logger.APIs.info("\nURL: \(response.url!)\nSTATUS-CODE: \(response.statusCode)\nRESPONSE: \(String(data: data, encoding: .utf8)!)")
		return (data, response)
	}
}
