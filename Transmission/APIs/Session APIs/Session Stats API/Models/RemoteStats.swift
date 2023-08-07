//
//  RemoteStats.swift
//  Transmission
//
//  Created by Federico Arvat on 15/07/23.
//

import Foundation

public struct RemoteStats: Decodable {
	let arguments: Arguments
	
	struct Arguments:  Decodable {
		let activeTorrentCount: Int
		let downloadSpeed: Int
	}
}
