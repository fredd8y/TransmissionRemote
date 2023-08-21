//
//  TorrentPeersPagePresenterTests.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 20/08/23.
//

import XCTest
@testable import Transmission

final class TorrentPeersPagePresenterTests: XCTorrentTestCase {
	
	private let table = "TorrentPeers"
	
	func test_title_isLocalized() {
		XCTAssertEqual(TorrentPeersPagePresenter.title, localized("TITLE", table: table))
	}
	
	func test_percentage_isLocalized() {
		XCTAssertEqual(TorrentPeersPagePresenter.percentage, localized("PERCENTAGE", table: table))
	}
	
	func test_status_isLocalized() {
		XCTAssertEqual(TorrentPeersPagePresenter.status, localized("STATUS", table: table))
	}
	
	func test_client_isLocalized() {
		XCTAssertEqual(TorrentPeersPagePresenter.client, localized("CLIENT", table: table))
	}
	
	func test_map_createsViewModel() {
		let progress = 0.97
		let status = "Status1"
		let address = "Address1"
		let clientName = "Client1"
		
		let viewModel = TorrentPeersPagePresenter.map([
			TorrentPeer(
				progress: progress,
				status: status,
				address: address,
				clientName: clientName
			)
		])
		
		XCTAssertEqual(viewModel.peers.first?.percentage, "97,00%")
//		XCTAssertEqual(viewModel.peers.first?.status, status)
//		XCTAssertEqual(viewModel.peers.first?.address, address)
//		XCTAssertEqual(viewModel.peers.first?.client, clientName)
	}
	
}
