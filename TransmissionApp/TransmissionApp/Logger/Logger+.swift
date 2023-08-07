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
}
