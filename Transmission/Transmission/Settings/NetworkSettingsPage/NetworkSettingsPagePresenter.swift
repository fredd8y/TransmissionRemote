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
	
	
	public static var listeningPort: String {
		NSLocalizedString(
			"LISTENING_PORT",
			tableName: "NetworkSettings",
			bundle: Bundle(for: NetworkSettingsPagePresenter.self),
			comment: "Listening port description")
	}
	
	public static var peerListeningPort: String {
		NSLocalizedString(
			"PEER_LISTENING_PORT",
			tableName: "NetworkSettings",
			bundle: Bundle(for: NetworkSettingsPagePresenter.self),
			comment: "Peer listening port description")
	}
	
	
	public static var mustBeANumberError: String {
		NSLocalizedString(
			"MUST_BE_A_NUMBER_ERROR",
			tableName: "NetworkSettings",
			bundle: Bundle(for: NetworkSettingsPagePresenter.self),
			comment: "Must be a number error description")
	}
	
	public static var randomizePortOnLaunch: String {
		NSLocalizedString(
			"RANDOMIZE_PORT_ON_LAUNCH",
			tableName: "NetworkSettings",
			bundle: Bundle(for: NetworkSettingsPagePresenter.self),
			comment: "Randomize port on launch description")
	}
	
	
	public static var portForwardingFromRouter: String {
		NSLocalizedString(
			"PORT_FORWARDING_FROM_ROUTER",
			tableName: "NetworkSettings",
			bundle: Bundle(for: NetworkSettingsPagePresenter.self),
			comment: "Port forwarding from my router description")
	}
	
	public static var enableUtpForCommunication: String {
		NSLocalizedString(
			"ENABLE_UTP_FOR_COMMUNICATION",
			tableName: "NetworkSettings",
			bundle: Bundle(for: NetworkSettingsPagePresenter.self),
			comment: "Enable utp for communication peers description")
	}
	
	public static var confirm: String {
		NSLocalizedString(
			"CONFIRM",
			tableName: "NetworkSettings",
			bundle: Bundle(for: NetworkSettingsPagePresenter.self),
			comment: "Confirm button description")
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
