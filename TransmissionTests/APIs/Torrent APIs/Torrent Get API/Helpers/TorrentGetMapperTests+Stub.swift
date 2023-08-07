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
		error: Int,
		errorString: String,
		eta: Int,
		id: Int,
		isFinished: Bool,
		percentDone: Double,
		rateDownload: Int,
		result: String
	) -> (model: [Torrent], json: [String: Any]) {
		let torrents = [
			Torrent(
				error: error,
				errorString: errorString,
				eta: eta,
				id: id,
				isFinished: isFinished,
				percentDone: percentDone,
				rateDownload: rateDownload
			)
		]
		return (model: torrents, json: [
			"arguments": [
				"torrents": [[
					"error": error,
					"errorString": errorString,
					"eta": eta,
					"id": id,
					"isFinished": isFinished,
					"percentDone": percentDone,
					"rateDownload": rateDownload
				]]
			],
			"result": result
		])
	}
}
