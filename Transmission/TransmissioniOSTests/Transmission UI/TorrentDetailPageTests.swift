//
//  TorrentDetailPageTests.swift
//  TransmissioniOSTests
//
//  Created by Federico Arvat on 18/08/23.
//

import XCTest
@testable import Transmission
@testable import TransmissioniOS

class TorrentDetailPageTests: XCTestCase {
	func test_torrentDetailPage() {
		let sut = makeSUT()
		
		assert(snapshot: sut.snapshot(.iPhone13(style: .light)), named: "TORRENT_DETAIL_PAGE_light")
		assert(snapshot: sut.snapshot(.iPhone13(style: .dark)), named: "TORRENT_DETAIL_PAGE_dark")
		assert(snapshot: sut.snapshot(.iPhone13(style: .light, contentSize: .extraExtraExtraLarge)), named: "TORRENT_DETAIL_PAGE_light_extraExtraExtraLarge")
	}
	func test_torrentDetailPageWithErrorMessage() {
		let sut = makeSUT(errorMessage: "Error message")
		
		assert(snapshot: sut.snapshot(.iPhone13(style: .light)), named: "TORRENT_DETAIL_PAGE_WITH_ERROR_MESSAGE_light")
		assert(snapshot: sut.snapshot(.iPhone13(style: .dark)), named: "TORRENT_DETAIL_PAGE_WITH_ERROR_MESSAGE_dark")
		assert(snapshot: sut.snapshot(.iPhone13(style: .light, contentSize: .extraExtraExtraLarge)), named: "TORRENT_DETAIL_PAGE_WITH_ERROR_MESSAGE_light_extraExtraExtraLarge")
	}
	
	// MARK: - Helpers
	
	private func makeSUT(errorMessage: String? = nil) -> TorrentDetailPage {
		TorrentDetailPage(
			viewModel: TorrentDetailPageViewModel(
				name: "Torrent name",
				errorMessage: errorMessage,
				percentageCompleted: "56,98%",
				uploaded: "123,00 MB",
				ratio: "0,09",
				downloaded: "234,98 MB",
				state: "Downloading",
				runningTime: "24 hours",
				remainingTime: "2 hours",
				lastActivity: "12 hours ago",
				error: "None",
				size: "123,00 GB",
				location: "/here",
				hash: "ex2m190ixs9021ixs90m1i2s",
				privacy: "Public torrent"
			)
		)
	}
}
