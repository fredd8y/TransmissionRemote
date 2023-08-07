//
//  Int+Byte.swift
//  Transmission
//
//  Created by Federico Arvat on 26/07/23.
//

import Foundation

extension Int {
	var byteSize: String {
		switch self {
		case 0 ..< 1_000: // Byte
			return "\(self) B"
		case 1_001 ..< 1_000_000: // Kbyte
			return "\((Double(self) / Double(1_000)).round() ?? "-") KB"
		case 1_000_001 ..< 1_000_000_000: // Mbyte
			return "\((Double(self) / Double(1_000_000)).round() ?? "-") MB"
		case 1_000_000_001 ..< 1_000_000_000_000: // Gbyte
			return "\((Double(self) / Double(1_000_000_000)).round() ?? "-") GB"
		case 1_000_000_000_001 ..< 1_000_000_000_000_000: // Tbyte
			return "\((Double(self) / Double(1_000_000_000_000)).round() ?? "-") TB"
		default:
			return "-"
		}
	}
}
