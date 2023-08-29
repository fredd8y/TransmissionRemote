//
//  NetworkSettingsPagePresenter.swift
//  Transmission
//
//  Created by Federico Arvat on 29/08/23.
//

import Foundation

public class NetworkSettingsPagePresenter {
	public static var title: String {
		NSLocalizedString(
			"NETWORK_SETTINGS_PAGE_TITLE",
			tableName: "NetworkSettings",
			bundle: Bundle(for: NetworkSettingsPagePresenter.self),
			comment: "Network settings page title")
	}
	
	public static var portOpen: String {
		NSLocalizedString(
			"PORT_OPEN",
			tableName: "NetworkSettings",
			bundle: Bundle(for: NetworkSettingsPagePresenter.self),
			comment: "Port open description")
	}
	
	public static var portClosed: String {
		NSLocalizedString(
			"PORT_CLOSED",
			tableName: "NetworkSettings",
			bundle: Bundle(for: NetworkSettingsPagePresenter.self),
			comment: "Port closed description")
	}
	
	public static func map(
		peerPort: Int,
		peerPortRandomOnStart: Bool,
		portForwardingEnabled: Bool,
		utpEnabled: Bool,
		portOpen: Bool
	) -> NetworkSettingsPageViewModel {
		NetworkSettingsPageViewModel(
			errorMessage: nil,
			isLoading: false,
			peerPort: peerPort.description,
			peerPortError: false,
			peerPortRandomOnStart: peerPortRandomOnStart,
			portForwardingEnabled: portForwardingEnabled,
			utpEnabled: utpEnabled,
			portStatus: portOpen ? NetworkSettingsPagePresenter.portOpen : NetworkSettingsPagePresenter.portClosed
		)
	}
}
