//
//  TorrentPeer.swift
//  Transmission
//
//  Created by Federico Arvat on 20/08/23.
//

import Foundation

public struct TorrentPeer: Equatable {
	public init(progress: Double, status: String, address: String, clientName: String) {
		self.progress = progress
		self.status = status
		self.address = address
		self.clientName = clientName
	}
	
	let progress: Double
	let status: String
	let address: String
	let clientName: String
}
