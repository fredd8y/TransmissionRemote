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
	
	func test_sessionGet_httpBodyWithFields() {
		let expectedBody = #"{"method":"session-get","arguments":{"fields":["field1","field2","field3"]}}"#.data(using: .utf8)
		
		let httpBody = SessionBodies.get(fields: ["field1", "field2", "field3"])
		
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
	
	func test_setStartAddedTorrentEnable_httpBody() {
		let expectedBody = #"{"method":"session-set","arguments":{"start-added-torrents":true}}"#.data(using: .utf8)
		
		let httpBody = SessionBodies.setStartAddedTorrents(enabled: true)
		
		XCTAssertEqual(expectedBody, httpBody)
	}
	
	func test_setStartAddedTorrentDisable_httpBody() {
		let expectedBody = #"{"method":"session-set","arguments":{"start-added-torrents":false}}"#.data(using: .utf8)
		
		let httpBody = SessionBodies.setStartAddedTorrents(enabled: false)
		
		XCTAssertEqual(expectedBody, httpBody)
	}
	
	func test_setRenamePartialFilesEnable_httpBody() {
		let expectedBody = #"{"method":"session-set","arguments":{"rename-partial-files":true}}"#.data(using: .utf8)
		
		let httpBody = SessionBodies.setRenamePartialFiles(enabled: true)
		
		XCTAssertEqual(expectedBody, httpBody)
	}
	
	func test_setRenamePartialFilesDisable_httpBody() {
		let expectedBody = #"{"method":"session-set","arguments":{"rename-partial-files":false}}"#.data(using: .utf8)
		
		let httpBody = SessionBodies.setRenamePartialFiles(enabled: false)
		
		XCTAssertEqual(expectedBody, httpBody)
	}
	
	func test_setSeedRatioLimitedEnable_httpBody() {
		let expectedBody = #"{"method":"session-set","arguments":{"seedRatioLimited":true}}"#.data(using: .utf8)
		
		let httpBody = SessionBodies.setSeedRatioLimited(enabled: true)
		
		XCTAssertEqual(expectedBody, httpBody)
	}
	
	func test_setSeedRatioLimitedDisable_httpBody() {
		let expectedBody = #"{"method":"session-set","arguments":{"seedRatioLimited":false}}"#.data(using: .utf8)
		
		let httpBody = SessionBodies.setSeedRatioLimited(enabled: false)
		
		XCTAssertEqual(expectedBody, httpBody)
	}
	
	func test_setSeedRatioLimit_httpBody() {
		let expectedBody = #"{"method":"session-set","arguments":{"seedRatioLimit":3}}"#.data(using: .utf8)
		
		let httpBody = SessionBodies.setSeedRatioLimit(limit: 3)
		
		XCTAssertEqual(expectedBody, httpBody)
	}
	
	func test_setIdleSeedingLimitEnabledEnable_httpBody() {
		let expectedBody = #"{"method":"session-set","arguments":{"idle-seeding-limit-enabled":true}}"#.data(using: .utf8)
		
		let httpBody = SessionBodies.setIdleSeedingLimitEnabled(enabled: true)
		
		XCTAssertEqual(expectedBody, httpBody)
	}
	
	func test_setIdleSeedingLimitEnabledDisable_httpBody() {
		let expectedBody = #"{"method":"session-set","arguments":{"idle-seeding-limit-enabled":false}}"#.data(using: .utf8)
		
		let httpBody = SessionBodies.setIdleSeedingLimitEnabled(enabled: false)
		
		XCTAssertEqual(expectedBody, httpBody)
	}
	
	func test_setIdleSeedingLimit_httpBody() {
		let expectedBody = #"{"method":"session-set","arguments":{"idle-seeding-limit":30}}"#.data(using: .utf8)
		
		let httpBody = SessionBodies.setIdleSeedingLimit(limit: 30)
		
		XCTAssertEqual(expectedBody, httpBody)
	}
	
	func test_setDownloadDir_httpBody() {
		let expectedBody = #"{"method":"session-set","arguments":{"download-dir":"a download dir"}}"#.data(using: .utf8)
		
		let httpBody = SessionBodies.setDownloadDir(downloadDir: "a download dir")
		
		XCTAssertEqual(expectedBody, httpBody)
	}
	
}
