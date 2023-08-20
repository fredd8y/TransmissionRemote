//
//  TorrentPeersMapperTests.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 20/08/23.
//

import Transmission
import XCTest

class TorrentPeersMapperTests: XCTestCase {
	// MARK: Internal
	
	func test_map_throwsErrorOnNon200HTTPResponse() throws {
		let json = makeJSON(fromDictionary: [:])
		let samples = [199, 201, 300, 408, 500]
		
		try samples.forEach { code in
			XCTAssertThrowsError(
				try TorrentPeersMapper.map(json, from: HTTPURLResponse(statusCode: code))
			)
		}
	}
	
	func test_map_throwsErrorOn200HTTPResponseWithInvalidJson() throws {
		let json = Data("invalid json".utf8)
		
		XCTAssertThrowsError(
			try TorrentPeersMapper.map(json, from: HTTPURLResponse(statusCode: 200))
		)
	}
	
	func test_map_throwsErrorOn200HTTPResponseWithEmptyJSON() throws {
		XCTAssertThrowsError(
			try TorrentPeersMapper.map(Data(), from: HTTPURLResponse(statusCode: 200))
		)
	}
	
	func test_map_throwsErrorOnMissingTorrent() throws {
		let noTorrentResponse = makeResponseWithoutTorrent()
		
		let json = makeJSON(fromDictionary: noTorrentResponse)
		
		XCTAssertThrowsError(
			try TorrentPeersMapper.map(json, from: HTTPURLResponse(statusCode: 200))
		)
	}
	
	func test_map_throwsErrorOnResponseWithMoreThanOneTorrent() throws {
		let noTorrentResponse = makeResponseWithMoreThanOneTorrent()
		
		let json = makeJSON(fromDictionary: noTorrentResponse)
		
		XCTAssertThrowsError(
			try TorrentPeersMapper.map(json, from: HTTPURLResponse(statusCode: 200))
		)
	}
	
	func test_map_deliversTorrentPeersOn200HTTPResponseWithValidJSON() {
		let torrentDetail = makeTorrentPeers()
		
		let json = makeJSON(fromDictionary: torrentDetail.json)
		
		do {
			let result = try TorrentPeersMapper.map(json, from: HTTPURLResponse(statusCode: 200))
			
			XCTAssertEqual(result, torrentDetail.model)
		} catch {
			XCTFail("Expected no exception, got \(error.localizedDescription) instead")
		}
	}
	
	// MARK: - Helpers
	
	private func makeTorrentPeers() -> (model: [TorrentPeer], json: [String: Any]) {
		let torrentDetail = [
			TorrentPeer(
				progress: 0.54,
				status: "T?EH",
				address: "2001:470:e01f:700::30",
				clientName: "qBittorrent 4.2.5"
			),
			TorrentPeer(
				progress: 0.57,
				status: "TKEU",
				address: "2001:470:e01f:700::40",
				clientName: "qBittorrent 4.5.5"
			)
		]
		let json: [String: Any] = [
			"arguments": [
				"torrents": [
					[
						"peers": [
							[
								"address": "2001:470:e01f:700::30",
								"clientIsChoked": true,
								"clientIsInterested": false,
								"clientName": "qBittorrent 4.2.5",
								"flagStr": "T?EH",
								"isDownloadingFrom": false,
								"isEncrypted": true,
								"isIncoming": false,
								"isUTP": true,
								"isUploadingTo": false,
								"peerIsChoked": false,
								"peerIsInterested": false,
								"port": 51413,
								"progress": 0.54,
								"rateToClient": 0,
								"rateToPeer": 0
							],
							[
								"address": "2001:470:e01f:700::40",
								"clientIsChoked": true,
								"clientIsInterested": false,
								"clientName": "qBittorrent 4.5.5",
								"flagStr": "TKEU",
								"isDownloadingFrom": false,
								"isEncrypted": true,
								"isIncoming": false,
								"isUTP": true,
								"isUploadingTo": false,
								"peerIsChoked": false,
								"peerIsInterested": false,
								"port": 51413,
								"progress": 0.57,
								"rateToClient": 0,
								"rateToPeer": 0
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
						"peers": [
							[
								"address": "2001:470:e01f:700::30",
								"clientIsChoked": true,
								"clientIsInterested": false,
								"clientName": "qBittorrent 4.2.5",
								"flagStr": "T?EH",
								"isDownloadingFrom": false,
								"isEncrypted": true,
								"isIncoming": false,
								"isUTP": true,
								"isUploadingTo": false,
								"peerIsChoked": false,
								"peerIsInterested": false,
								"port": 51413,
								"progress": 0.54,
								"rateToClient": 0,
								"rateToPeer": 0
							]
						]
					],
					[
						"peers": [
							[
								"address": "2001:470:e01f:700::30",
								"clientIsChoked": true,
								"clientIsInterested": false,
								"clientName": "qBittorrent 4.2.5",
								"flagStr": "T?EH",
								"isDownloadingFrom": false,
								"isEncrypted": true,
								"isIncoming": false,
								"isUTP": true,
								"isUploadingTo": false,
								"peerIsChoked": false,
								"peerIsInterested": false,
								"port": 51413,
								"progress": 0.54,
								"rateToClient": 0,
								"rateToPeer": 0
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
