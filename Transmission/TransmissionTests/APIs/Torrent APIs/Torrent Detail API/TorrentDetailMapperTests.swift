//
//  TorrentDetailMapperTests.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 17/08/23.
//

import Transmission
import XCTest

class TorrentDetailMapperTests: XCTestCase {
	// MARK: Internal

	func test_map_throwsErrorOnNon200HTTPResponse() throws {
		let json = makeJSON(fromDictionary: [:])
		let samples = [199, 201, 300, 408, 500]

		try samples.forEach { code in
			XCTAssertThrowsError(
				try TorrentDetailMapper.map(json, from: HTTPURLResponse(statusCode: code))
			)
		}
	}

	func test_map_throwsErrorOn200HTTPResponseWithInvalidJson() throws {
		let json = Data("invalid json".utf8)

		XCTAssertThrowsError(
			try TorrentDetailMapper.map(json, from: HTTPURLResponse(statusCode: 200))
		)
	}

	func test_map_throwsErrorOn200HTTPResponseWithEmptyJSON() throws {
		XCTAssertThrowsError(
			try TorrentDetailMapper.map(Data(), from: HTTPURLResponse(statusCode: 200))
		)
	}

	func test_map_throwsErrorOnMissingTorrent() throws {
		let noTorrentResponse = makeResponseWithoutTorrent()
		
		let json = makeJSON(fromDictionary: noTorrentResponse)
		
		XCTAssertThrowsError(
			try TorrentDetailMapper.map(json, from: HTTPURLResponse(statusCode: 200))
		)
	}

	func test_map_throwsErrorOnResponseWithMoreThanOneTorrent() throws {
		let noTorrentResponse = makeResponseWithMoreThanOneTorrent()
		
		let json = makeJSON(fromDictionary: noTorrentResponse)
		
		XCTAssertThrowsError(
			try TorrentDetailMapper.map(json, from: HTTPURLResponse(statusCode: 200))
		)
	}

	func test_map_deliversTorrentDetailOn200HTTPResponseWithValidJSON() {
		let torrentDetail = makeTorrentDetail()

		let json = makeJSON(fromDictionary: torrentDetail.json)

		do {
			let result = try TorrentDetailMapper.map(json, from: HTTPURLResponse(statusCode: 200))

			XCTAssertEqual(result, torrentDetail.model)
		} catch {
			XCTFail("Expected no exception, got \(error.localizedDescription) instead")
		}
	}

	// MARK: - Helpers

	private func makeTorrentDetail() -> (model: TorrentDetail, json: [String: Any]) {
		let name = "a name"
		let percentageAvailability = 0.67
		let uploaded = 3002549145
		let ratio = 0.08
		let downloaded = 3002549145
		let state = Status.downloading
		let startDate = 1692197318
		let eta = 87656789
		let lastActivity = 1692258808
		let error = ""
		let size = 876545678
		let location = "a location"
		let hash = "jd9130jdn910md9210mx9120m9210"
		let isPrivate = false
		
		let torrentDetail = TorrentDetail(
			name: name,
			percentageAvailability: percentageAvailability,
			uploaded: uploaded,
			ratio: ratio,
			downloaded: downloaded,
			state: state,
			startDate: startDate,
			eta: eta,
			lastActivity: lastActivity,
			error: error,
			size: size,
			location: location,
			hash: hash,
			isPrivate: isPrivate
		)
		let json: [String: Any] = [
			"arguments": [
				"torrents": [
					[
						"name": name,
						"downloadDir": location,
						"errorString": error,
						"eta": eta,
						"hashString": hash,
						"uploadRatio": ratio,
						"uploadedEver": uploaded,
						"percentDone": percentageAvailability,
						"totalSize": size,
						"isPrivate": isPrivate,
						"status": 4,
						"activityDate": 1692258808,
						"downloadedEver": 3002549145,
						"startDate": 1692197318
					]
				]
			],
			"result": "success"
		]
		return (torrentDetail, json)
	}
	
	private func makeResponseWithoutTorrent() -> [String: Any] {
		let json: [String: Any] = [
			"arguments": [
				"torrents": []
			],
			"result": "success"
		]
		return json
	}
	
	private func makeResponseWithMoreThanOneTorrent() -> [String: Any] {
		let json: [String: Any] = [
			"arguments": [
				"torrents": [
					[
						"name": "name",
						"downloadDir": "location",
						"errorString": "error",
						"eta": 1234567,
						"hashString": "hash",
						"uploadRatio": 0.09,
						"uploadedEver": 1234567,
						"percentDone": 0.0987,
						"rateDownload": 213213,
						"rateUpload": 321321,
						"totalSize": 1234567,
						"isPrivate": false,
						"status": 4,
						"activityDate": 1692258808,
						"downloadedEver": 3002549145,
						"startDate": 1692197318
					],
					[
						"name": "name",
						"downloadDir": "location",
						"errorString": "error",
						"eta": 1234567,
						"hashString": "hash",
						"uploadRatio": 0.09,
						"uploadedEver": 1234567,
						"percentDone": 0.0987,
						"rateDownload": 213213,
						"rateUpload": 321321,
						"totalSize": 1234567,
						"isPrivate": false,
						"status": 4,
						"activityDate": 1692258808,
						"downloadedEver": 3002549145,
						"startDate": 1692197318
					]
				]
			],
			"result": "success"
		]
		return json
	}
}
