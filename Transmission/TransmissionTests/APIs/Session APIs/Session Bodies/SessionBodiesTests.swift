//
//  SessionBodiesTests.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 13/05/23.
//

import XCTest
@testable import Transmission

final class SessionBodiesTests: XCTestCase {
	
	func test_sessionGet_httpBody() {
		let expectedBody = #"{"method": "session-get"}"#
		
		let httpBody = SessionBodies.get
		
		XCTAssertEqual(expectedBody, httpBody)
	}
	
	func test_sessionGet_httpBodyWithFields() {
		let expectedBody = #"{"arguments":{"fields":["field1","field2","field3"]},"method":"session-get"}"#.data(using: .utf8)!
		
		let httpBody = SessionBodies.get(fields: ["field1", "field2", "field3"])
		
		assertEqual(expectedBody, httpBody)
	}
	
	func test_sessionStats_httpBody() {
		let expectedBody = #"{"method": "session-stats"}"#.data(using: .utf8)!
		
		let httpBody = SessionBodies.stats.data(using: .utf8)!
		
		assertEqual(expectedBody, httpBody)
	}
	
	func test_setDownloadLimitEnable_httpBody() {
		let expectedBody = #"{"arguments":{"alt-speed-enabled":true},"method":"session-set"}"#.data(using: .utf8)!
		
		let httpBody = SessionBodies.setDownloadLimit(enabled: true)
		
		assertEqual(expectedBody, httpBody)
	}
	
	func test_setDownloadLimitDisable_httpBody() {
		let expectedBody = #"{"arguments":{"alt-speed-enabled":false},"method":"session-set"}"#.data(using: .utf8)!
		
		let httpBody = SessionBodies.setDownloadLimit(enabled: false)
		
		assertEqual(expectedBody, httpBody)
	}
	
	func test_setStartAddedTorrentEnable_httpBody() {
		let expectedBody = #"{"arguments":{"start-added-torrents":true},"method":"session-set"}"#.data(using: .utf8)!
		
		let httpBody = SessionBodies.setStartAddedTorrents(enabled: true)
		
		assertEqual(expectedBody, httpBody)
	}
	
	func test_setStartAddedTorrentDisable_httpBody() {
		let expectedBody = #"{"arguments":{"start-added-torrents":false},"method":"session-set"}"#.data(using: .utf8)!
		
		let httpBody = SessionBodies.setStartAddedTorrents(enabled: false)
		
		assertEqual(expectedBody, httpBody)
	}
	
	func test_setRenamePartialFilesEnable_httpBody() {
		let expectedBody = #"{"arguments":{"rename-partial-files":true},"method":"session-set"}"#.data(using: .utf8)!
		
		let httpBody = SessionBodies.setRenamePartialFiles(enabled: true)
		
		assertEqual(expectedBody, httpBody)
	}
	
	func test_setRenamePartialFilesDisable_httpBody() {
		let expectedBody = #"{"arguments":{"rename-partial-files":false},"method":"session-set"}"#.data(using: .utf8)!
		
		let httpBody = SessionBodies.setRenamePartialFiles(enabled: false)
		
		assertEqual(expectedBody, httpBody)
	}
	
	func test_setSeedRatioLimitedEnable_httpBody() {
		let expectedBody = #"{"arguments":{"seedRatioLimited":true},"method":"session-set"}"#.data(using: .utf8)!
		
		let httpBody = SessionBodies.setSeedRatioLimited(enabled: true)
		
		assertEqual(expectedBody, httpBody)
	}
	
	func test_setSeedRatioLimitedDisable_httpBody() {
		let expectedBody = #"{"arguments":{"seedRatioLimited":false},"method":"session-set"}"#.data(using: .utf8)!
		
		let httpBody = SessionBodies.setSeedRatioLimited(enabled: false)
		
		assertEqual(expectedBody, httpBody)
	}
	
	func test_setSeedRatioLimit_httpBody() {
		let expectedBody = #"{"arguments":{"seedRatioLimit":3},"method":"session-set"}"#.data(using: .utf8)!
		
		let httpBody = SessionBodies.setSeedRatioLimit(limit: 3)
		
		assertEqual(expectedBody, httpBody)
	}
	
	func test_setIdleSeedingLimitEnabledEnable_httpBody() {
		let expectedBody = #"{"arguments":{"idle-seeding-limit-enabled":true},"method":"session-set"}"#.data(using: .utf8)!
		
		let httpBody = SessionBodies.setIdleSeedingLimitEnabled(enabled: true)
		
		assertEqual(expectedBody, httpBody)
	}
	
	func test_setIdleSeedingLimitEnabledDisable_httpBody() {
		let expectedBody = #"{"arguments":{"idle-seeding-limit-enabled":false},"method":"session-set"}"#.data(using: .utf8)!
		
		let httpBody = SessionBodies.setIdleSeedingLimitEnabled(enabled: false)
		
		assertEqual(expectedBody, httpBody)
	}
	
	func test_setIdleSeedingLimit_httpBody() {
		let expectedBody = #"{"arguments":{"idle-seeding-limit":30},"method":"session-set"}"#.data(using: .utf8)!
		
		let httpBody = SessionBodies.setIdleSeedingLimit(limit: 30)
		
		assertEqual(expectedBody, httpBody)
	}
	
	func test_setDownloadDir_httpBody() {
		let expectedBody = #"{"arguments":{"download-dir":"a download dir"},"method":"session-set"}"#.data(using: .utf8)!
		
		let httpBody = SessionBodies.setDownloadDir(downloadDir: "a download dir")
		
		assertEqual(expectedBody, httpBody)
	}
	
	private func assertEqual(
		_ arg0: Data,
		_ arg1: Data,
		file: StaticString = #filePath,
		line: UInt = #line
	) {
		XCTAssertEqual(
			arg0,
			arg1,
			"Expected \(String(data: arg0, encoding: .utf8)!) and \(String(data: arg1, encoding: .utf8)!) to be equal"
		)
	}
	
}
