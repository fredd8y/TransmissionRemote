//
//  PeersSettingsPagePresenter.swift
//  Transmission
//
//  Created by Federico Arvat on 28/08/23.
//

import Foundation

public class PeersSettingsPagePresenter {
	public static var title: String {
		NSLocalizedString(
			"PEERS_SETTINGS_PAGE_TITLE",
			tableName: "PeersSettings",
			bundle: Bundle(for: TorrentsSettingsPagePresenter.self),
			comment: "Torrents settings page title")
	}

	public static func map(_ peersSettings: PeersSettings) -> PeersSettingsPageViewModel {
		PeersSettingsPageViewModel(
			errorMessage: nil,
			isLoading: false,
			peerLimitGlobal: peersSettings.peerLimitGlobal.description,
			peerLimitGlobalError: false,
			peerLimitPerTorrent: peersSettings.peerLimitPerTorrent.description,
			peerLimitPerTorrentError: false,
			pexEnabled: peersSettings.pexEnabled,
			dhtEnabled: peersSettings.dhtEnabled,
			lpdEnabled: peersSettings.lpdEnabled,
			blocklistEnabled: peersSettings.blocklistEnabled,
			blocklistSize: peersSettings.blocklistSize.description,
			blocklistUrl: peersSettings.blocklistUrl,
			blocklistUrlError: false,
			encryption: peersSettings.encryption.viewModelEncryption
		)
	}
}

extension PeersSettings.Encryption {
	var viewModelEncryption: PeersSettingsPageViewModel.Encryption {
		switch self {
		case .required: return .required
		case .preferred: return .preferred
		case .tolerated: return .tolerated
		}
	}
}
