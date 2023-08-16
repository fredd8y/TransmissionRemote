//
//  SessionBodiesTests.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 13/05/23.
//

import XCTest
import Transmission

final class SessionBodiesTests: XCTestCase {
	
	func test_sessionGet_httpBody() {
		let expectedBody = #"{"method": "session-get"}"#
		
		let httpBody = SessionBodies.get
		
		XCTAssertEqual(expectedBody, httpBody)
	}
	
	func test_sessionStats_httpBody() {
		let expectedBody = #"{"method": "session-stats"}"#
		
		let httpBody = SessionBodies.stats
		
		XCTAssertEqual(expectedBody, httpBody)
	}
	
	func test_setDownloadLimitEnable_httpBody() {
		let expectedBody = #"{"method":"session-set","arguments":{"alt-speed-enabled":true}}"#.data(using: .utf8)
		
		let httpBody = SessionBodies.setDownloadLimit(enabled: true)
		
		XCTAssertEqual(expectedBody, httpBody)
	}
	
	func test_setDownloadLimitDisable_httpBody() {
		let expectedBody = #"{"method":"session-set","arguments":{"alt-speed-enabled":false}}"#.data(using: .utf8)
		
		let httpBody = SessionBodies.setDownloadLimit(enabled: false)
		
		XCTAssertEqual(expectedBody, httpBody)
	}
	
}
