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
	
	func test_requiredEncryptionDescription_isLocalized() {
		XCTAssertEqual(PeersSettingsPagePresenter.requiredEncryptionDescription, localized("REQUIRED_ENCRYPTION_DESCRIPTION", table: table))
	}
	
	func test_preferredEncryptionDescription_isLocalized() {
		XCTAssertEqual(PeersSettingsPagePresenter.preferredEncryptionDescription, localized("PREFERRED_ENCRYPTION_DESCRIPTION", table: table))
	}
	
	func test_toleratedEncryptionDescription_isLocalized() {
		XCTAssertEqual(PeersSettingsPagePresenter.toleratedEncryptionDescription, localized("TOLERATED_ENCRYPTION_DESCRIPTION", table: table))
	}
	
	func test_connections_isLocalized() {
		XCTAssertEqual(PeersSettingsPagePresenter.connections, localized("CONNECTIONS_SECTION_HEADER", table: table))
	}
	
	func test_options_isLocalized() {
		XCTAssertEqual(PeersSettingsPagePresenter.options, localized("OPTIONS_SECTION_HEADER", table: table))
	}
	
	func test_blocklist_isLocalized() {
		XCTAssertEqual(PeersSettingsPagePresenter.blocklist, localized("BLOCKLIST_SECTION_HEADER", table: table))
	}
	
	func test_blocklistRulesNumber_isLocalized() {
		XCTAssertEqual(PeersSettingsPagePresenter.blocklistRulesNumber, localized("BLOCKLIST_RULES_NUMBER", table: table))
	}
	
	func test_blocklistUrlPlaceholder_isLocalized() {
		XCTAssertEqual(PeersSettingsPagePresenter.blocklistUrlPlaceholder, localized("BLOCKLIST_URL_PLACEHOLDER", table: table))
	}
	
	func test_mapBlocklistSize() {
		let size = 12345
		
		let sizeDescription = PeersSettingsPagePresenter.mapBlocklistSize(size)
		
		XCTAssertEqual("\(PeersSettingsPagePresenter.blocklistRulesNumber): \(size)", sizeDescription)
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
		XCTAssertEqual("\(PeersSettingsPagePresenter.blocklistRulesNumber): \(blocklistSize)", viewModel.blocklistSize)
		XCTAssertEqual(blocklistUrl, viewModel.blocklistUrl)
		XCTAssertEqual(PeersSettingsPageViewModel.Encryption.tolerated, viewModel.encryption)
		
	}
	
}
