//
//  Base16Tests.swift
//  TransmissionAppTests
//
//  Created by Federico Arvat on 06/08/23.
//

import XCTest
import Foundation
@testable import TransmissionApp

class Base16Test: XCTestCase {
	func test_fromDataToStringSingleValues() {
		guard
			let zero = "0".data(using: .utf8),
			let one = "1".data(using: .utf8),
			let two = "2".data(using: .utf8),
			let three = "3".data(using: .utf8),
			let four = "4".data(using: .utf8),
			let five = "5".data(using: .utf8),
			let six = "6".data(using: .utf8),
			let seven = "7".data(using: .utf8),
			let eight = "8".data(using: .utf8),
			let nine = "9".data(using: .utf8),
			let ten = "A".data(using: .utf8),
			let eleven = "B".data(using: .utf8),
			let twelve = "C".data(using: .utf8),
			let thirteen = "D".data(using: .utf8),
			let fourteen = "E".data(using: .utf8),
			let fifteen = "F".data(using: .utf8)
		else {
			XCTFail("There's something wrong with data conversion")
			return
		}
		guard zero.base16EncodedString() == "30" else {
			XCTFail("There's something wrong with 0 conversion")
			return
		}
		guard one.base16EncodedString() == "31" else {
			XCTFail("There's something wrong with 1 conversion")
			return
		}
		guard two.base16EncodedString() == "32" else {
			XCTFail("There's something wrong with 2 conversion")
			return
		}
		guard three.base16EncodedString() == "33" else {
			XCTFail("There's something wrong with 3 conversion")
			return
		}
		guard four.base16EncodedString() == "34" else {
			XCTFail("There's something wrong with 4 conversion")
			return
		}
		guard five.base16EncodedString() == "35" else {
			XCTFail("There's something wrong with 5 conversion")
			return
		}
		guard six.base16EncodedString() == "36" else {
			XCTFail("There's something wrong with 6 conversion")
			return
		}
		guard seven.base16EncodedString() == "37" else {
			XCTFail("There's something wrong with 7 conversion")
			return
		}
		guard eight.base16EncodedString() == "38" else {
			XCTFail("There's something wrong with 8 conversion")
			return
		}
		guard nine.base16EncodedString() == "39" else {
			XCTFail("There's something wrong with 9 conversion")
			return
		}
		guard ten.base16EncodedString() == "41" else {
			XCTFail("There's something wrong with 10 conversion")
			return
		}
		guard eleven.base16EncodedString() == "42" else {
			XCTFail("There's something wrong with 11 conversion")
			return
		}
		guard twelve.base16EncodedString() == "43" else {
			XCTFail("There's something wrong with 12 conversion")
			return
		}
		guard thirteen.base16EncodedString() == "44" else {
			XCTFail("There's something wrong with 13 conversion")
			return
		}
		guard fourteen.base16EncodedString() == "45" else {
			XCTFail("There's something wrong with 14 conversion")
			return
		}
		guard fifteen.base16EncodedString() == "46" else {
			XCTFail("There's something wrong with 15 conversion")
			return
		}
	}
	
	func test_fromDataToString() {
		guard let data = "0123456789ABCDEF".data(using: .utf8) else { return }
		XCTAssertTrue(data.base16EncodedString() == "30313233343536373839414243444546")
	}
	
	func test_fromStringToData() {
		guard let data = "0123456789ABCDEF".data(using: .utf8) else { return }
		XCTAssertTrue(Data(base16Encoded: "30313233343536373839414243444546") == data)
	}
	
	func test_fromDataToStringBackToData() {
		guard let data = "0123456789ABCDEF".data(using: .utf8) else { return }
		XCTAssertTrue(Data(base16Encoded: data.base16EncodedString()) == "0123456789ABCDEF".data(using: .utf8))
	}
	
	func test_fromStringToDataBackToString() {
		let data = Data(base16Encoded: "30313233343536373839414243444546")
		XCTAssertTrue("30313233343536373839414243444546" == data.base16EncodedString())
	}
}
