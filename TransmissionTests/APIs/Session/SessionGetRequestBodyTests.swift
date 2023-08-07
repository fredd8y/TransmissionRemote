//
//  SessionGetRequestBodyTests.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 13/05/23.
//

import XCTest
import Transmission

final class SessionGetRequestBodyTests: XCTestCase {
	
	func test_sessionGet_httpBody() {
		let expectedBody = #"{"method": "session-get"}"#
		
		let httpBody = SessionGetRequestBody.body
		
		XCTAssertEqual(expectedBody, httpBody)
	}
	
}
