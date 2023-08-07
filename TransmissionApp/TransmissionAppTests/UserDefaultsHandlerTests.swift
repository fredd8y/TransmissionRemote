//
//  UserDefaultsHandlerTests.swift
//  TransmissionAppTests
//
//  Created by Federico Arvat on 28/07/23.
//

import XCTest
@testable import TransmissionApp

final class UserDefaultsHandlerTests: XCTestCase {
	
	func test_updatePollingRate() {
		let testValue = Int.random(in: 0..<1000)
		
		UserDefaultsHandler.shared.pollingRate = testValue
		
		XCTAssertEqual(testValue, UserDefaultsHandler.shared.pollingRate)
	}

}
