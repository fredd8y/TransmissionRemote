//
//  NetworkSettingsPresenterTests.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 29/08/23.
//

import XCTest
import Transmission

final class NetworkSettingsPresenterTests: XCTestCase {
	
	private let table = "NetworkSettings"
	
	func test_title_isLocalized() {
		XCTAssertEqual(NetworkSettingsPagePresenter.title, localized("NETWORK_SETTINGS_PAGE_TITLE", table: table))
	}
	
	func test_map_createsViewModel() {
		let peerPort = 51413
		let peerPortRandomOnStart = false
		let portForwardingEnabled = false
		let utpEnabled = true
		let portOpen = false
		
		let viewModel = NetworkSettingsPagePresenter.map(
			peerPort: peerPort,
			peerPortRandomOnStart: peerPortRandomOnStart,
			portForwardingEnabled: portForwardingEnabled,
			utpEnabled: utpEnabled,
			portOpen: portOpen
		)
		
		XCTAssertEqual(viewModel.peerPort, peerPort.description)
		XCTAssertEqual(viewModel.peerPortRandomOnStart, peerPortRandomOnStart)
		XCTAssertEqual(viewModel.portForwardingEnabled, portForwardingEnabled)
		XCTAssertEqual(viewModel.utpEnabled, utpEnabled)
		XCTAssertEqual(viewModel.portStatus, NetworkSettingsPagePresenter.portClosed)
	}
	
}
