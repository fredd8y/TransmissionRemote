//
//  SessionStatsMapperTests+Stub.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 15/07/23.
//

import Foundation
@testable import Transmission

extension SessionStatsMapperTests {
	func makeStats(activeTorrentCount: Int, downloadSpeed: Int) -> (model: Stats, json: [String: Any]) {
		let stats = Stats(activeTorrentCount: activeTorrentCount, downloadSpeed: downloadSpeed)
		return (model: stats, json: [
			"arguments": [
				"activeTorrentCount": activeTorrentCount,
				"downloadSpeed": downloadSpeed
			]
		])
	}
}
