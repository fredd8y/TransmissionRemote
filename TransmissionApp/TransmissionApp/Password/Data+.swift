//
//  Data+.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 06/08/23.
//

import Foundation

extension Data {
	/// Use this method to encode a Data value into a Base16 String
	/// - Returns: The Base16 String encoded Data
	func base16EncodedString() -> String {
		let base16chars = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F"]
		var hexArray = [String](repeating: "", count: self.count * 2)
		self.enumerated().forEach { i, item in
			let currentHexArrayIndex = i * 2
			hexArray[currentHexArrayIndex] = base16chars[Int((item & 0b11110000) >> 4)]
			hexArray[currentHexArrayIndex + 1] = base16chars[Int(item & 0b00001111)]
		}
		return hexArray.joined()
	}
	
	/// Use this method to decode a Base16 String into a Data
	/// - Parameter string: The String that has to be decoded
	init(base16Encoded string: String) {
		var stringArray = [UInt8](repeating: 0, count: 71)
		stringArray[48] = 0b00000000
		stringArray[49] = 0b00000001
		stringArray[50] = 0b00000010
		stringArray[51] = 0b00000011
		stringArray[52] = 0b00000100
		stringArray[53] = 0b00000101
		stringArray[54] = 0b00000110
		stringArray[55] = 0b00000111
		stringArray[56] = 0b00001000
		stringArray[57] = 0b00001001
		stringArray[65] = 0b00001010
		stringArray[66] = 0b00001011
		stringArray[67] = 0b00001100
		stringArray[68] = 0b00001101
		stringArray[69] = 0b00001110
		stringArray[70] = 0b00001111
		var byteArray = [UInt8](repeating: 0, count: string.count / 2)
		var byteArrayIndex: Int = 0
		var temp: UInt8 = 0
		string.enumerated().forEach { i, item in
			guard let asciiValue = item.asciiValue else { return }
			if i % 2 == 0 {
				temp = stringArray[Int(asciiValue)] << 4
			} else {
				byteArray[byteArrayIndex] = temp | stringArray[Int(asciiValue)]
				byteArrayIndex += 1
			}
		}
		self = Data(byteArray)
	}
}
