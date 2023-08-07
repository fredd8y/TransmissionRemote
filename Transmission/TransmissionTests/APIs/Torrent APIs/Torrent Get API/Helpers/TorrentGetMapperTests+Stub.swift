//
//  TorrentGetMapperTests+Stub.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 17/05/23.
//

import Foundation
@testable import Transmission

extension TorrentGetMapperTests {
	func makeRemoteTorrents(
		name: String,
		error: Int,
		errorString: String,
		eta: Int,
		id: Int,
		isFinished: Bool,
		percentDone: Double,
		rateDownload: Int,
		rateUpload: Int,
		totalSize: Int,
		result: String
	) -> (model: [Torrent], json: [String: Any]) {
		let torrents = [
			Torrent(
				name: name,
				error: error,
				errorString: errorString,
				eta: eta,
				id: id,
				isFinished: isFinished,
				percentDone: percentDone,
				rateDownload: rateDownload,
				rateUpload: rateUpload,
				totalSize: totalSize,
				status: .downloading
			)
		]
		return (model: torrents, json: [
			"arguments": [
				"torrents": [[
					"name": name,
					"error": error,
					"errorString": errorString,
					"eta": eta,
					"id": id,
					"isFinished": isFinished,
					"percentDone": percentDone,
					"rateDownload": rateDownload,
					"rateUpload": rateUpload,
					"totalSize": totalSize,
					"status": 4
				]]
			],
			"result": result
		])
	}
}
