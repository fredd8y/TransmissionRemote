//
//  PortTestBodiesTests.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 29/08/23.
//

import XCTest
import Transmission

final class PortTestBodiesTests: XCTestCase {
	
	func test_portTest_httpBody() {
		let expectedBody = #"{"method": "port-test"}"#.data(using: .utf8)!
		
		let httpBody = PortTestBodies.test
		
		XCTAssertEqual(expectedBody, httpBody)
	}
	
}
