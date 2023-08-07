//
//  RemoteTorrents.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 17/05/23.
//

import Foundation

public struct RemoteTorrents: Decodable {
	let arguments: Arguments
	let result: String
	
	struct Arguments: Decodable {
		let torrents: [RemoteTorrent]
		
		struct RemoteTorrent: Decodable {
			let error: Int
			let errorString: String
			let eta: Int
			let id: Int
			let isFinished: Bool
			let percentDone: Double
			let rateDownload: Int
		}
	}
	
	var torrents: [Torrent] {
		arguments.torrents.map {
			Torrent(
				error: $0.error,
				errorString: $0.errorString,
				eta: $0.eta,
				id: $0.id,
				isFinished: $0.isFinished,
				percentDone: $0.percentDone,
				rateDownload: $0.rateDownload
			)
		}
	}
}
