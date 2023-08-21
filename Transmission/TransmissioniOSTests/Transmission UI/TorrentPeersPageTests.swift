//
//  TorrentPeersPageTests.swift
//  TransmissioniOSTests
//
//  Created by Federico Arvat on 21/08/23.
//

import XCTest
@testable import Transmission
@testable import TransmissioniOS

class TorrentPeersPageTests: XCTestCase {
	func test_torrentDetailPage() {
		let sut = makeSUT()
		
		assert(snapshot: sut.snapshot(.iPhone13(style: .light)), named: "TORRENT_PEERS_PAGE_light")
		assert(snapshot: sut.snapshot(.iPhone13(style: .dark)), named: "TORRENT_PEERS_PAGE_dark")
		assert(snapshot: sut.snapshot(.iPhone13(style: .light, contentSize: .extraExtraExtraLarge)), named: "TORRENT_PEERS_PAGE_light_extraExtraExtraLarge")
	}
	func test_torrentDetailPageWithErrorMessage() {
		let sut = makeSUT(errorMessage: "Error message")
		
		assert(snapshot: sut.snapshot(.iPhone13(style: .light)), named: "TORRENT_PEERS_PAGE_WITH_ERROR_MESSAGE_light")
		assert(snapshot: sut.snapshot(.iPhone13(style: .dark)), named: "TORRENT_PEERS_PAGE_WITH_ERROR_MESSAGE_dark")
		assert(snapshot: sut.snapshot(.iPhone13(style: .light, contentSize: .extraExtraExtraLarge)), named: "TORRENT_PEERS_PAGE_WITH_ERROR_MESSAGE_light_extraExtraExtraLarge")
	}
	
	// MARK: - Helpers
	
	private func makeSUT(errorMessage: String? = nil) -> TorrentPeersPage {
		TorrentPeersPage(
			viewModel: TorrentPeersPageViewModel(
				peers: [
					TorrentPeersPageViewModel.Peer(percentage: "100,00%", status: "TKI", address: "2602:fe90:100:1a1a::", client: "qBittorrent 4.5.4"),
					TorrentPeersPageViewModel.Peer(percentage: "100,00%", status: "TI", address: "2a03:1b20:4:f011::a03e", client: "qBittorrent 4.5.4"),
					TorrentPeersPageViewModel.Peer(percentage: "100,00%", status: "TUEX", address: "178.16.86.114", client: "-UW1303-")
				],
				errorMessage: errorMessage
			)
		)
	}
}
