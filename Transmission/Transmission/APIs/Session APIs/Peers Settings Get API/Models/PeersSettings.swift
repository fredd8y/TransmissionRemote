//
//  PeersSettings.swift
//  Transmission
//
//  Created by Federico Arvat on 28/08/23.
//

import Foundation

public class PeersSettings: Equatable, ObservableObject {
	public static func == (lhs: PeersSettings, rhs: PeersSettings) -> Bool {
		return lhs.peerLimitGlobal == rhs.peerLimitGlobal &&
		lhs.peerLimitPerTorrent == rhs.peerLimitPerTorrent &&
		lhs.pexEnabled == rhs.pexEnabled &&
		lhs.dhtEnabled == rhs.dhtEnabled &&
		lhs.lpdEnabled == rhs.lpdEnabled &&
		lhs.blocklistEnabled == rhs.blocklistEnabled &&
		lhs.blocklistSize == rhs.blocklistSize &&
		lhs.blocklistUrl == rhs.blocklistUrl &&
		lhs.encryption == rhs.encryption
	}
	
	public init(
		peerLimitGlobal: Int,
		peerLimitPerTorrent: Int,
		pexEnabled: Bool,
		dhtEnabled: Bool,
		lpdEnabled: Bool,
		blocklistEnabled: Bool,
		blocklistSize: Int,
		blocklistUrl: String,
		encryption: PeersSettings.Encryption
	) {
		self.peerLimitGlobal = peerLimitGlobal
		self.peerLimitPerTorrent = peerLimitPerTorrent
		self.pexEnabled = pexEnabled
		self.dhtEnabled = dhtEnabled
		self.lpdEnabled = lpdEnabled
		self.blocklistEnabled = blocklistEnabled
		self.blocklistSize = blocklistSize
		self.blocklistUrl = blocklistUrl
		self.encryption = encryption
	}
	
	let peerLimitGlobal: Int
	let peerLimitPerTorrent: Int
	let pexEnabled: Bool
	let dhtEnabled: Bool
	let lpdEnabled: Bool
	let blocklistEnabled: Bool
	let blocklistSize: Int
	let blocklistUrl: String
	let encryption: Encryption
	
	public enum Encryption: String, Decodable, Equatable {
		case required
		case preferred
		case tolerated
	}

}
