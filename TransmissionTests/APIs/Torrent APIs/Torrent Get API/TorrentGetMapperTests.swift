//
//  TorrentGetMapperTests.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 16/05/23.
//

import XCTest
import Transmission

class TorrentGetMapperTests: XCTestCase {
	func test_map_throwsErrorOnNon200HTTPResponse() throws {
		let json = makeJSON(fromDictionary: [:])
		let samples = [199, 201, 300, 408, 500]
		
		try samples.forEach { code in
			XCTAssertThrowsError(
				try TorrentGetMapper.map(json, from: HTTPURLResponse(statusCode: code))
			)
		}
	}
	
	func test_map_throwsErrorOn200HTTPResponseWithInvalidJson() throws {
		let json = Data("invalid json".utf8)
		
		XCTAssertThrowsError(
			try TorrentGetMapper.map(json, from: HTTPURLResponse(statusCode: 200))
		)
	}
	
	func test_map_throwsErrorOn200HTTPResponseWithEmptyJSON() throws {
		XCTAssertThrowsError(
			try TorrentGetMapper.map(Data(), from: HTTPURLResponse(statusCode: 200))
		)
	}
	
	func test_map_deliversTorrentsOn200HTTPResponseWithValidJSON() {
		let torrents = makeTorrents()
		
		let json = makeJSON(fromDictionary: torrents.json)
		
		do {
			let result = try TorrentGetMapper.map(json, from: HTTPURLResponse(statusCode: 200))
			
			XCTAssertEqual(result, torrents.model)
		} catch {
			XCTFail("Expected no exception, got \(error.localizedDescription) instead")
		}
	}
	
	// MARK: - Helpers

	private func makeJSON(fromDictionary dictionary: [String: Any]) -> Data {
		return try! JSONSerialization.data(withJSONObject: dictionary)
	}
	
	
	private func makeTorrents() -> (model: [Torrent], json: [String: Any]) {
		return makeRemoteTorrents(
			error: 0,
			errorString: "",
			eta: 2222,
			id: 7,
			isFinished: false,
			percentDone: 0.76,
			rateDownload: 2733000,
			result: "success"
		)
	}
}
