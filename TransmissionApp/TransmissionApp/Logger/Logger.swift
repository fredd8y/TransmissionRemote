//
//  Logger.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 07/08/23.
//

import OSLog

extension Logger {
	static func log(_ data: Data, from response: HTTPURLResponse) throws -> (data: Data, response: HTTPURLResponse) {
		return (data, response)
	}
}
