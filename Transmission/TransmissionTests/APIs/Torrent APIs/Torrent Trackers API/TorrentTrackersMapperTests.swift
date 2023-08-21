//
//  TorrentTrackersMapperTests.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 21/08/23.
//

import Transmission
import XCTest

class TorrentTrackersMapperTests: XCTestCase {
	// MARK: Internal
	
	func test_map_throwsErrorOnNon200HTTPResponse() throws {
		let json = makeJSON(fromDictionary: [:])
		let samples = [199, 201, 300, 408, 500]
		
		try samples.forEach { code in
			XCTAssertThrowsError(
				try TorrentTrackersMapper.map(json, from: HTTPURLResponse(statusCode: code))
			)
		}
	}
	
	func test_map_throwsErrorOn200HTTPResponseWithInvalidJson() throws {
		let json = Data("invalid json".utf8)
		
		XCTAssertThrowsError(
			try TorrentTrackersMapper.map(json, from: HTTPURLResponse(statusCode: 200))
		)
	}
	
	func test_map_throwsErrorOn200HTTPResponseWithEmptyJSON() throws {
		XCTAssertThrowsError(
			try TorrentTrackersMapper.map(Data(), from: HTTPURLResponse(statusCode: 200))
		)
	}
	
	func test_map_throwsErrorOnMissingTorrent() throws {
		let noTorrentResponse = makeResponseWithoutTorrent()
		
		let json = makeJSON(fromDictionary: noTorrentResponse)
		
		XCTAssertThrowsError(
			try TorrentTrackersMapper.map(json, from: HTTPURLResponse(statusCode: 200))
		)
	}
	
	func test_map_throwsErrorOnResponseWithMoreThanOneTorrent() throws {
		let noTorrentResponse = makeResponseWithMoreThanOneTorrent()
		
		let json = makeJSON(fromDictionary: noTorrentResponse)
		
		XCTAssertThrowsError(
			try TorrentTrackersMapper.map(json, from: HTTPURLResponse(statusCode: 200))
		)
	}
	
	func test_map_deliversTorrentTrackersOn200HTTPResponseWithValidJSON() {
		let torrentDetail = makeTorrentTrackers()
		
		let json = makeJSON(fromDictionary: torrentDetail.json)
		
		do {
			let result = try TorrentTrackersMapper.map(json, from: HTTPURLResponse(statusCode: 200))
			
			XCTAssertEqual(result, torrentDetail.model)
		} catch {
			XCTFail("Expected no exception, got \(error.localizedDescription) instead")
		}
	}
	
	// MARK: - Helpers
	
	private func makeTorrentTrackers() -> (model: [TorrentTracker], json: [String: Any]) {
		let torrentDetail = [
			TorrentTracker(
				id: 0,
				host: "udp://tracker.opentrackr.org:1337",
				lastAnnounceTime: 1692604237,
				lastAnnouncePeerCount: 80,
				nextAnnounceTime: 1692605881,
				lastScrapeTime: 1692604570,
				seederCount: 509,
				leecherCount: 5,
				downloadCount: 12745
			),
			TorrentTracker(
				id: 1,
				host: "udp://tracker.opentrackr.org:1337",
				lastAnnounceTime: 1692604237,
				lastAnnouncePeerCount: 80,
				nextAnnounceTime: 1692605881,
				lastScrapeTime: 1692604570,
				seederCount: 509,
				leecherCount: 5,
				downloadCount: 12745
			)
		]
		let json: [String: Any] = [
			"arguments": [
				"torrents": [
					[
						"trackerStats": [
							[
								"announce": "udp://tracker.opentrackr.org:1337/announce",
								"announceState": 1,
								"downloadCount": 12745,
								"hasAnnounced": true,
								"hasScraped": true,
								"host": "udp://tracker.opentrackr.org:1337",
								"id": 0,
								"isBackup": false,
								"lastAnnouncePeerCount": 80,
								"lastAnnounceResult": "Success",
								"lastAnnounceStartTime": 1692604235,
								"lastAnnounceSucceeded": true,
								"lastAnnounceTime": 1692604237,
								"lastAnnounceTimedOut": false,
								"lastScrapeResult": "",
								"lastScrapeStartTime": 1692604570,
								"lastScrapeSucceeded": true,
								"lastScrapeTime": 1692604570,
								"lastScrapeTimedOut": false,
								"leecherCount": 5,
								"nextAnnounceTime": 1692605881,
								"nextScrapeTime": 1692606370,
								"scrape": "udp://tracker.opentrackr.org:1337/scrape",
								"scrapeState": 1,
								"seederCount": 509,
								"tier": 0
							],
							[
								"announce": "udp://tracker.opentrackr.org:1337/announce",
								"announceState": 1,
								"downloadCount": 12745,
								"hasAnnounced": true,
								"hasScraped": true,
								"host": "udp://tracker.opentrackr.org:1337",
								"id": 1,
								"isBackup": false,
								"lastAnnouncePeerCount": 80,
								"lastAnnounceResult": "Success",
								"lastAnnounceStartTime": 1692604235,
								"lastAnnounceSucceeded": true,
								"lastAnnounceTime": 1692604237,
								"lastAnnounceTimedOut": false,
								"lastScrapeResult": "",
								"lastScrapeStartTime": 1692604570,
								"lastScrapeSucceeded": true,
								"lastScrapeTime": 1692604570,
								"lastScrapeTimedOut": false,
								"leecherCount": 5,
								"nextAnnounceTime": 1692605881,
								"nextScrapeTime": 1692606370,
								"scrape": "udp://tracker.opentrackr.org:1337/scrape",
								"scrapeState": 1,
								"seederCount": 509,
								"tier": 0
							]
						]
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
						"trackerStats": [
							[
								"announce": "udp://tracker.opentrackr.org:1337/announce",
								"announceState": 1,
								"downloadCount": 12745,
								"hasAnnounced": true,
								"hasScraped": true,
								"host": "udp://tracker.opentrackr.org:1337",
								"id": 1,
								"isBackup": false,
								"lastAnnouncePeerCount": 80,
								"lastAnnounceResult": "Success",
								"lastAnnounceStartTime": 1692604235,
								"lastAnnounceSucceeded": true,
								"lastAnnounceTime": 1692604237,
								"lastAnnounceTimedOut": false,
								"lastScrapeResult": "",
								"lastScrapeStartTime": 1692604570,
								"lastScrapeSucceeded": true,
								"lastScrapeTime": 1692604570,
								"lastScrapeTimedOut": false,
								"leecherCount": 5,
								"nextAnnounceTime": 1692605881,
								"nextScrapeTime": 1692606370,
								"scrape": "udp://tracker.opentrackr.org:1337/scrape",
								"scrapeState": 1,
								"seederCount": 509,
								"tier": 0
							]
						]
					],
					[
						"peers": [
							[
								"announce": "udp://tracker.opentrackr.org:1337/announce",
								"announceState": 1,
								"downloadCount": 12745,
								"hasAnnounced": true,
								"hasScraped": true,
								"host": "udp://tracker.opentrackr.org:1337",
								"id": 1,
								"isBackup": false,
								"lastAnnouncePeerCount": 80,
								"lastAnnounceResult": "Success",
								"lastAnnounceStartTime": 1692604235,
								"lastAnnounceSucceeded": true,
								"lastAnnounceTime": 1692604237,
								"lastAnnounceTimedOut": false,
								"lastScrapeResult": "",
								"lastScrapeStartTime": 1692604570,
								"lastScrapeSucceeded": true,
								"lastScrapeTime": 1692604570,
								"lastScrapeTimedOut": false,
								"leecherCount": 5,
								"nextAnnounceTime": 1692605881,
								"nextScrapeTime": 1692606370,
								"scrape": "udp://tracker.opentrackr.org:1337/scrape",
								"scrapeState": 1,
								"seederCount": 509,
								"tier": 0
							]
						]
					]
				]
			],
			"result": "success"
		]
		return json
	}
	
	
	
}
