//
//  Int+Byte.swift
//  Transmission
//
//  Created by Federico Arvat on 26/07/23.
//

import Foundation

extension Int {
	var byteSize: String {
		
		let byte = 1024
		let kByte = 1024 * byte
		let mByte = 1024 * kByte
		let gByte = 1024 * mByte
		let tbyte = 1024 * gByte
		
		switch self {
		case 0 ..< byte: // Byte
			return "\(self) B"
		case byte + 1 ..< kByte: // Kbyte
			return "\((Double(self) / Double(byte)).round() ?? "-") KB"
		case kByte + 1 ..< mByte: // Mbyte
			return "\((Double(self) / Double(kByte)).round() ?? "-") MB"
		case mByte + 1 ..< gByte: // Gbyte
			return "\((Double(self) / Double(mByte)).round() ?? "-") GB"
		case gByte + 1 ..< tbyte: // Tbyte
			return "\((Double(self) / Double(gByte)).round() ?? "-") TB"
		default:
			return "-"
		}
	}
	
	var speed: String {
		byteSize + "/s"
	}
	
	var kilobyteSpeed: String {
		(self * 1024).byteSize + "/s"
	}
}
