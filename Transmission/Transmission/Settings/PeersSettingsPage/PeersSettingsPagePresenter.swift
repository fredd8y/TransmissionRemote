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

	public static var requiredEncryptionDescription: String {
		NSLocalizedString(
			"REQUIRED_ENCRYPTION_DESCRIPTION",
			tableName: "PeersSettings",
			bundle: Bundle(for: TorrentsSettingsPagePresenter.self),
			comment: "Required encryption description")
	}

	public static var preferredEncryptionDescription: String {
		NSLocalizedString(
			"PREFERRED_ENCRYPTION_DESCRIPTION",
			tableName: "PeersSettings",
			bundle: Bundle(for: TorrentsSettingsPagePresenter.self),
			comment: "Preferred encryption description")
	}

	public static var toleratedEncryptionDescription: String {
		NSLocalizedString(
			"TOLERATED_ENCRYPTION_DESCRIPTION",
			tableName: "PeersSettings",
			bundle: Bundle(for: TorrentsSettingsPagePresenter.self),
			comment: "Tolerated encryption description")
	}
	
	public static var connections: String {
		NSLocalizedString(
			"CONNECTIONS_SECTION_HEADER",
			tableName: "PeersSettings",
			bundle: Bundle(for: TorrentsSettingsPagePresenter.self),
			comment: "Connections section header title")
	}
	
	public static var options: String {
		NSLocalizedString(
			"OPTIONS_SECTION_HEADER",
			tableName: "PeersSettings",
			bundle: Bundle(for: TorrentsSettingsPagePresenter.self),
			comment: "Options section header title")
	}
	
	public static var blocklist: String {
		NSLocalizedString(
			"BLOCKLIST_SECTION_HEADER",
			tableName: "PeersSettings",
			bundle: Bundle(for: TorrentsSettingsPagePresenter.self),
			comment: "Blocklist section header title")
	}
	
	public static var maxPeersPerTorrent: String {
		NSLocalizedString(
			"MAX_PEERS_PER_TORRENT",
			tableName: "PeersSettings",
			bundle: Bundle(for: TorrentsSettingsPagePresenter.self),
			comment: "Max peers per torrent textfield description")
	}
	
	public static var maxPeersOverall: String {
		NSLocalizedString(
			"MAX_PEERS_OVERALL",
			tableName: "PeersSettings",
			bundle: Bundle(for: TorrentsSettingsPagePresenter.self),
			comment: "Max peers overall textfield description")
	}
	
	public static var mustBeANumber: String {
		NSLocalizedString(
			"MUST_BE_A_NUMBER",
			tableName: "PeersSettings",
			bundle: Bundle(for: TorrentsSettingsPagePresenter.self),
			comment: "Must be a number error")
	}
	
	public static var encryptionMode: String {
		NSLocalizedString(
			"ENCRYPTION_MODE",
			tableName: "PeersSettings",
			bundle: Bundle(for: TorrentsSettingsPagePresenter.self),
			comment: "Encryption mode picker title")
	}
	
	public static var pexDescription: String {
		NSLocalizedString(
			"PEX_DESCRIPTION",
			tableName: "PeersSettings",
			bundle: Bundle(for: TorrentsSettingsPagePresenter.self),
			comment: "Pex description")
	}
	
	public static var dhtDescription: String {
		NSLocalizedString(
			"DHT_DESCRIPTION",
			tableName: "PeersSettings",
			bundle: Bundle(for: TorrentsSettingsPagePresenter.self),
			comment: "Dht description")
	}
	
	public static var lpdDescription: String {
		NSLocalizedString(
			"LPD_DESCRIPTION",
			tableName: "PeersSettings",
			bundle: Bundle(for: TorrentsSettingsPagePresenter.self),
			comment: "Lpd description")
	}
	
	public static var enableBlocklist: String {
		NSLocalizedString(
			"ENABLE_BLOCKLIST",
			tableName: "PeersSettings",
			bundle: Bundle(for: TorrentsSettingsPagePresenter.self),
			comment: "Enbled blocklist toggle title")
	}
	
	public static var mustBeAnUrl: String {
		NSLocalizedString(
			"MUST_BE_AN_URL",
			tableName: "PeersSettings",
			bundle: Bundle(for: TorrentsSettingsPagePresenter.self),
			comment: "Must be an url error")
	}
	
	public static var update: String {
		NSLocalizedString(
			"UPDATE_BUTTON_TITLE",
			tableName: "PeersSettings",
			bundle: Bundle(for: TorrentsSettingsPagePresenter.self),
			comment: "Update button title")
	}
	
	public static var confirm: String {
		NSLocalizedString(
			"CONFIRM_BUTTON_TITLE",
			tableName: "PeersSettings",
			bundle: Bundle(for: TorrentsSettingsPagePresenter.self),
			comment: "Confirm button keyboard title")
	}
	
	public static func map(_ peersSettings: PeersSettings) -> PeersSettingsPageViewModel {
		PeersSettingsPageViewModel(
			alertMessage: nil,
			alertMessageVisible: false,
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
