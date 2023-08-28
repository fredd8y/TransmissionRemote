//
//  PeersSettingsPageViewModel+Factory.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 28/08/23.
//

import Foundation
import Transmission

extension PeersSettingsPageViewModel {
	static func loading() -> PeersSettingsPageViewModel {
		PeersSettingsPageViewModel(
			errorMessage: nil,
			isLoading: true,
			peerLimitGlobal: "-",
			peerLimitGlobalError: false,
			peerLimitPerTorrent: "-",
			peerLimitPerTorrentError: false,
			pexEnabled: false,
			dhtEnabled: false,
			lpdEnabled: false,
			blocklistEnabled: false,
			blocklistSize: "-",
			blocklistUrl: "-",
			blocklistUrlError: false,
			encryption: .preferred
		)
	}

	static func error(_ errorMessage: String) -> PeersSettingsPageViewModel {
		PeersSettingsPageViewModel(
			errorMessage: errorMessage,
			isLoading: false,
			peerLimitGlobal: "-",
			peerLimitGlobalError: false,
			peerLimitPerTorrent: "-",
			peerLimitPerTorrentError: false,
			pexEnabled: false,
			dhtEnabled: false,
			lpdEnabled: false,
			blocklistEnabled: false,
			blocklistSize: "-",
			blocklistUrl: "-",
			blocklistUrlError: false,
			encryption: .preferred
		)
	}
}
