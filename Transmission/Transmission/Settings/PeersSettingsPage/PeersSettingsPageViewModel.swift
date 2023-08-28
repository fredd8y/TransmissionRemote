//
//  PeersSettingsPageViewModel.swift
//  Transmission
//
//  Created by Federico Arvat on 28/08/23.
//

import Foundation

public class PeersSettingsPageViewModel: ObservableObject {
	public init(
		errorMessage: String?,
		isLoading: Bool,
		peerLimitGlobal: String,
		peerLimitGlobalError: Bool,
		peerLimitPerTorrent: String,
		peerLimitPerTorrentError: Bool,
		pexEnabled: Bool,
		dhtEnabled: Bool,
		lpdEnabled: Bool,
		blocklistEnabled: Bool,
		blocklistSize: String,
		blocklistUrl: String,
		blocklistUrlError: Bool,
		encryption: PeersSettingsPageViewModel.Encryption
	) {
		self.errorMessage = errorMessage
		self.isLoading = isLoading
		self.peerLimitGlobal = peerLimitGlobal
		self.peerLimitGlobalError = peerLimitGlobalError
		self.peerLimitPerTorrent = peerLimitPerTorrent
		self.peerLimitPerTorrentError = peerLimitPerTorrentError
		self.pexEnabled = pexEnabled
		self.dhtEnabled = dhtEnabled
		self.lpdEnabled = lpdEnabled
		self.blocklistEnabled = blocklistEnabled
		self.blocklistSize = blocklistSize
		self.blocklistUrl = blocklistUrl
		self.blocklistUrlError = blocklistUrlError
		self.encryption = encryption
	}
	
	@Published public var errorMessage: String?
	@Published public var isLoading: Bool
	@Published public var peerLimitGlobal: String
	@Published public var peerLimitGlobalError: Bool
	@Published public var peerLimitPerTorrent: String
	@Published public var peerLimitPerTorrentError: Bool
	@Published public var pexEnabled: Bool
	@Published public var dhtEnabled: Bool
	@Published public var lpdEnabled: Bool
	@Published public var blocklistEnabled: Bool
	@Published public var blocklistSize: String
	@Published public var blocklistUrl: String
	@Published public var blocklistUrlError: Bool
	@Published public var encryption: Encryption
	
	public enum Encryption: CaseIterable {
		case required
		case preferred
		case tolerated
	}
	
}
