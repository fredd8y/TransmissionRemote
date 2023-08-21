//
//  Int+Byte.swift
//  Transmission
//
//  Created by Federico Arvat on 26/07/23.
//

import Foundation

extension Int {
	func byteSize(decimalSeparator: String? = nil) -> String {
		
		let byte = 1024
		let kByte = 1024 * byte
		let mByte = 1024 * kByte
		let gByte = 1024 * mByte
		let tbyte = 1024 * gByte
		
		switch self {
		case 0 ..< byte: // Byte
			return "\(self) B"
		case byte + 1 ..< kByte: // Kbyte
			return "\((Double(self) / Double(byte)).round(decimalSeparator: decimalSeparator) ?? "-") KB"
		case kByte + 1 ..< mByte: // Mbyte
			return "\((Double(self) / Double(kByte)).round(decimalSeparator: decimalSeparator) ?? "-") MB"
		case mByte + 1 ..< gByte: // Gbyte
			return "\((Double(self) / Double(mByte)).round(decimalSeparator: decimalSeparator) ?? "-") GB"
		case gByte + 1 ..< tbyte: // Tbyte
			return "\((Double(self) / Double(gByte)).round(decimalSeparator: decimalSeparator) ?? "-") TB"
		default:
			return "-"
		}
	}
	
	func speed(decimalSeparator: String? = nil) -> String {
		byteSize(decimalSeparator: decimalSeparator) + "/s"
	}
	
	func kilobyteSpeed(decimalSeparator: String? = nil) -> String {
		(self * 1024).byteSize(decimalSeparator: decimalSeparator) + "/s"
	}
}
