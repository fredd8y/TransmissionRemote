//
//  PeersSettingsPresenterTests.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 28/08/23.
//

import XCTest
import Transmission

final class PeersSettingsPresenterTests: XCTestCase {
	
	private let table = "PeersSettings"
	
	func test_title_isLocalized() {
		XCTAssertEqual(PeersSettingsPagePresenter.title, localized("PEERS_SETTINGS_PAGE_TITLE", table: table))
	}
	
	func test_map_createsViewModel() {
		let peerLimitGlobal = 500
		let peerLimitPerTorrent = 25
		let pexEnabled = true
		let dhtEnabled = true
		let lpdEnabled = true
		let blocklistEnabled = true
		let blocklistSize = 12345
		let blocklistUrl = "an url"
		let encryption = PeersSettings.Encryption.tolerated
				
		let viewModel = PeersSettingsPagePresenter.map(PeersSettings(
			peerLimitGlobal: peerLimitGlobal,
			peerLimitPerTorrent: peerLimitPerTorrent,
			pexEnabled: pexEnabled,
			dhtEnabled: dhtEnabled,
			lpdEnabled: lpdEnabled,
			blocklistEnabled: blocklistEnabled,
			blocklistSize: blocklistSize,
			blocklistUrl: blocklistUrl,
			encryption: encryption
		))

		XCTAssertEqual(peerLimitGlobal.description, viewModel.peerLimitGlobal)
		XCTAssertEqual(peerLimitPerTorrent.description, viewModel.peerLimitPerTorrent)
		XCTAssertEqual(pexEnabled, viewModel.pexEnabled)
		XCTAssertEqual(dhtEnabled, viewModel.dhtEnabled)
		XCTAssertEqual(lpdEnabled, viewModel.lpdEnabled)
		XCTAssertEqual(blocklistEnabled, viewModel.blocklistEnabled)
		XCTAssertEqual(blocklistSize.description, viewModel.blocklistSize)
		XCTAssertEqual(blocklistUrl, viewModel.blocklistUrl)
		XCTAssertEqual(PeersSettingsPageViewModel.Encryption.tolerated, viewModel.encryption)
		
	}
	
}
