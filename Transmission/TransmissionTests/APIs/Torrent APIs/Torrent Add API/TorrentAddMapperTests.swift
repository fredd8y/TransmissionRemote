//
//  TorrentAddMapperTests.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 03/08/23.
//

import XCTest
import Transmission

class TorrentAddMapperTests: XCTestCase {
	
	func test_map_throwsErrorOnNon200HTTPResponse() throws {
		let json = makeJSON(fromDictionary: [:])
		let samples = [199, 201, 300, 408, 500]
		
		try samples.forEach { code in
			XCTAssertThrowsError(
				try TorrentAddMapper.map(json, from: HTTPURLResponse(statusCode: code))
			)
		}
	}
	
	func test_map_throwsErrorOn200HTTPResponseWithInvalidJson() throws {
		let json = Data("invalid json".utf8)
		
		XCTAssertThrowsError(
			try TorrentAddMapper.map(json, from: HTTPURLResponse(statusCode: 200))
		)
	}
	
	func test_map_throwsErrorOn200HTTPResponseWithEmptyJSON() throws {
		XCTAssertThrowsError(
			try TorrentAddMapper.map(Data(), from: HTTPURLResponse(statusCode: 200))
		)
	}
	
	func test_map_throwsErrorOnResponseWithDuplicateTorrent() throws {
		let (duplicateTorrentName, json) = makeResponseWithDuplicateTorrent()
		let jsonData = makeJSON(fromDictionary: json)
		do {
			_ = try TorrentAddMapper.map(jsonData, from: HTTPURLResponse(statusCode: 200))
		} catch {
			guard let _error = error as? TorrentAddMapper.Error else {
				XCTFail("Expected error of type TorrentAddMapper.Error got \(error.self) instead")
				return
			}
			guard case let TorrentAddMapper.Error.torrentDuplicate(name) = _error else {
				XCTFail("Expected torrentDuplicate error got \(_error) instead")
				return
			}
			XCTAssertEqual(name, duplicateTorrentName)
		}
	}
	
	func test_map_throwsErrorOnResponseWithoutTorrent() throws {
		let jsonData = makeJSON(fromDictionary: makeResponseWithoutTorrent())
		XCTAssertThrowsError(
			try TorrentAddMapper.map(jsonData, from: HTTPURLResponse(statusCode: 200))
		)
	}
	
	func test_map_throwsErrorOnResponseWithoutSuccessResult() throws {
		let (json, apiError) = makeResponseWithFailure()
		
		let jsonData = makeJSON(fromDictionary: json)
		
		do {
			_ = try TorrentAddMapper.map(jsonData, from: HTTPURLResponse(statusCode: 200))
		} catch {
			if case let TorrentAddMapper.Error.failed(explanation) = error {
				XCTAssertEqual(explanation, apiError)
			} else {
				XCTFail("Expected TorrentAddMapper.Error.failed, got \(error) instead")
			}
		}
	}
	
	func test_map_succeedsOnResponseWithAddedTorrent() throws {
		let (expectedTorrentName, json) = makeResponseWithAddedTorrent()
		let jsonData = makeJSON(fromDictionary: json)
		do {
			let receivedTorrentName = try TorrentAddMapper.map(jsonData, from: HTTPURLResponse(statusCode: 200))
			XCTAssertEqual(expectedTorrentName, receivedTorrentName, "Expected that received torrent name to be equal of expected one, got \(receivedTorrentName) instead")
		} catch {
			XCTFail("Expected success, got \(error) instead")
		}
	}
	
	// MARK: - Helpers
	
	private func makeResponseWithDuplicateTorrent() -> (duplicateTorrentName: String, json: [String: Any]) {
		let torrentName = "a torrent name"
		let json: [String: Any] = [
			"arguments": [
				"torrent-duplicate": [
					"hashString": "e5f941ef7d5493c151f34bfdb799079c70f9929a",
					"id": 1,
					"name": torrentName
				]
			],
			"result": "success"
		]
		return (torrentName, json)
	}
	
	private func makeResponseWithAddedTorrent() -> (addedTorrentName: String, json: [String: Any]) {
		let torrentName = "a torrent name"
		let json: [String: Any] = [
			"arguments": [
				"torrent-added": [
					"hashString": "e5f941ef7d5493c151f34bfdb799079c70f9929a",
					"id": 1,
					"name": torrentName
				]
			],
			"result": "success"
		]
		return (torrentName, json)
	}
	
	private func makeResponseWithoutTorrent() -> [String: Any] {
		let json: [String: Any] = [
			"arguments": [:],
			"result": "success"
		]
		return json
	}
	
	private func makeResponseWithFailure() -> (json: [String: Any], error: String) {
		let error = "failed for some reason"
		
		let json: [String: Any] = [
			"arguments": [:],
			"result": error
		]
		return (json, error)
	}
	
}
