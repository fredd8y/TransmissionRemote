//
//  SessionGetMapperTest.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 14/05/23.
//

import XCTest
import Transmission

class SessionGetMapperTest: XCTestCase {
	
	func test_map_throwsAuthenticationErrorOn401HTTPStatus() throws {
		let json = makeJSON(fromDictionary: [:])
		
		do {
			_ = try SessionGetMapper.map(json, from: HTTPURLResponse(statusCode: 401))
		} catch {
			XCTAssertEqual(
				(error as! SessionGetMapper.Error),
				SessionGetMapper.Error.authenticationFailed,
				"Expected authenticationFailed error, got \(error) instead"
			)
		}
	}
	
	func test_map_throwsErrorOnHTTPResponseStatusCodeDifferentThan200And409() throws {
		let json = makeJSON(fromDictionary: [:])
		let samples = [199, 201, 300, 408, 410, 500]
		
		try samples.forEach { code in
			XCTAssertThrowsError(
				try SessionGetMapper.map(json, from: HTTPURLResponse(statusCode: code))
			)
		}
	}
	
	func test_map_throwsErrorOn200Or409ResponseWithInvalidJSON() throws {
		let invalidJson = Data("invalid json".utf8)
		let samples = [200, 409]
		
		try samples.forEach { code in
			XCTAssertThrowsError(
				try SessionGetMapper.map(invalidJson, from: HTTPURLResponse(statusCode: code))
			)
		}
	}
	
	func test_map_throwsErrorOn200HTTPResponseWithEmptyJSON() throws {
		XCTAssertThrowsError(
			try SessionGetMapper.map(Data(), from: HTTPURLResponse(statusCode: 200))
		)
	}
	
	func test_map_throwsSessionIdErrorOn409HTTPResponse() throws {
		let json = makeJSON(fromDictionary: [:])
		let sessionIdValue = anyString()
		do {
			_ = try SessionGetMapper.map(
				json,
				from: HTTPURLResponse(statusCode: 409, headerFields: [SessionGetMapper.sessionIdKey: sessionIdValue])
			)
		} catch {
			guard let _error = error as? SessionGetMapper.Error else {
				XCTFail("Expected SessionGetMapper.Error value, got \(error.self) instead")
				return
			}
			if case let SessionGetMapper.Error.missingSessionId(sessionId) = _error {
				if let retrievedSessionIdValue = sessionId as? String {
					XCTAssertEqual(sessionIdValue, retrievedSessionIdValue)
				} else {
					XCTFail("Expected String sessionIdValue value, got \(String(describing: sessionId)) instead")
				}
			} else {
				XCTFail("Expected SessionGetMapper.Error.missingSessionId value, got \(error.self) instead")
			}
		}
	}
	
	func test_map_deliversSessionItemOn200HTTPResponseWithValidJSON() {
		let sessionItem = makeSessionItem()

		let json = makeJSON(fromDictionary: sessionItem.json)

		do {
			let result = try SessionGetMapper.map(json, from: HTTPURLResponse(statusCode: 200))

			XCTAssertEqual(result, sessionItem.model)
		} catch {
			XCTFail("Expected no exception, got \(error.localizedDescription) instead")
		}
	}
	
	func test_map_throwsErrorOnResponseWithoutSuccessResult() throws {
		let result = "wrong result"
		let (_, json) = makeSessionItem(result)
		let jsonData = makeJSON(fromDictionary: json)
		
		do {
			_ = try SessionGetMapper.map(jsonData, from: HTTPURLResponse(statusCode: 200))
		} catch {
			if case let SessionGetMapper.Error.failed(explanation) = error {
				XCTAssertEqual(explanation, result)
			} else {
				XCTFail("Expected TorrentStartMapper.Error.failed, got \(error) instead")
			}
		}
	}
	
	// MARK: - Helpers
		
	private func makeSessionItem(_ result: String = "success") -> (model: Session, json: [String: Any]) {
		return makeSessionItem(
			altSpeedDown: Int.random(in: 50..<5000),
			altSpeedEnabled: Bool.random(),
			altSpeedTimeBegin: Int.random(in: 50..<5000),
			altSpeedTimeDay: Int.random(in: 50..<5000),
			altSpeedTimeEnabled: Bool.random(),
			altSpeedTimeEnd: Int.random(in: 50..<5000),
			altSpeedUp: Int.random(in: 50..<5000),
			blocklistEnabled: Bool.random(),
			blockListSize: Int.random(in: 50..<5000),
			blocklistUrl: anyURL().absoluteString,
			cacheSizeMb: Int.random(in: 50..<5000),
			configDir: anyURL().absoluteString,
			dhtEnabled: Bool.random(),
			downloadDir: anyURL().absoluteString,
			downloadDirFreeSpace: Int.random(in: 50..<5000),
			downloadQueueEnabled: Bool.random(),
			downloadQueueSize: Int.random(in: 50..<5000),
			encryption: "preferred",
			idleSeedingLimit: Int.random(in: 50..<5000),
			idleSeedingLimitEnabled: Bool.random(),
			incompleteDir: anyURL().absoluteString,
			incompleteDirEnabled: Bool.random(),
			lpdEnabled: Bool.random(),
			peerLimitGlobal: Int.random(in: 50..<5000),
			peerLimitPerTorrent: Int.random(in: 50..<5000),
			peerPort: Int.random(in: 50..<5000),
			peerPortRandomOnStart: Bool.random(),
			pexEnabled: Bool.random(),
			portForwardingEnabled: Bool.random(),
			queueStalledEnabled: Bool.random(),
			queueStalledMinutes: Int.random(in: 50..<5000),
			renamePartialFiles: Bool.random(),
			rpcVersion: Int.random(in: 50..<5000),
			rpcVersionMinimum: Int.random(in: 50..<5000),
			scriptTorrentDoneEnabled: Bool.random(),
			scriptTorrentDoneFilename: "any file name",
			seedQueueEnabled: Bool.random(),
			seedQueueSize: Int.random(in: 50..<5000),
			seedRatioLimit: Int.random(in: 50..<5000),
			seedRatioLimited: Bool.random(),
			sessionId: "any session id",
			speedLimitDown: Int.random(in: 50..<5000),
			speedLimitDownEnabled: Bool.random(),
			speedLimitUp: Int.random(in: 50..<5000),
			speedLimitUpEnabled: Bool.random(),
			startAddedTorrents: Bool.random(),
			trashOriginalTorrentFiles: Bool.random(),
			memoryBytes: Int.random(in: 50..<5000),
			memoryUnits: ["KiB", "MiB", "GiB", "TiB"],
			sizeBytes: Int.random(in: 50..<5000),
			sizeUnits: ["kB", "MB", "GB", "TB"],
			speedBytes: Int.random(in: 50..<5000),
			speedUnits: ["kB/s", "MB/s", "GB/s", "TB/s"],
			utpEnabled: Bool.random(),
			version: "any version",
			result: result
		)
	}
}
