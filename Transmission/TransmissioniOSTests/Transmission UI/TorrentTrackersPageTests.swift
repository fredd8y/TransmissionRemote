//
//  TorrentTrackersPageTests.swift
//  TransmissioniOSTests
//
//  Created by Federico Arvat on 21/08/23.
//

import XCTest
@testable import Transmission
@testable import TransmissioniOS

class TorrentTrackersPageTests: XCTestCase {
	func test_torrentDetailPage() {
		let sut = makeSUT()
		
		assert(snapshot: sut.snapshot(.iPhone13(style: .light)), named: "TORRENT_TRACKERS_PAGE_light")
		assert(snapshot: sut.snapshot(.iPhone13(style: .dark)), named: "TORRENT_TRACKERS_PAGE_dark")
		assert(snapshot: sut.snapshot(.iPhone13(style: .light, contentSize: .extraExtraExtraLarge)), named: "TORRENT_TRACKERS_PAGE_light_extraExtraExtraLarge")
	}
	
	// MARK: - Helpers
	
	private func makeSUT() -> TorrentTrackersPage {
		TorrentTrackersPage(
			viewModel: TorrentTrackersPageViewModel(
				trackers: [
					TorrentTrackersPageViewModel.Tracker(
						id: 1,
						host: "a host",
						lastAnnounceTime: "1 hour ago",
						lastAnnouncePeerCount: "1 hour ago",
						nextAnnounceTime: "in 4 hours",
						lastScrapeTime: "1 hour ago",
						seederCount: "12",
						leecherCount: "32",
						downloadCount: "12345"
					),
					TorrentTrackersPageViewModel.Tracker(
						id: 2,
						host: "another host",
						lastAnnounceTime: "2 hours ago",
						lastAnnouncePeerCount: "1 hour ago",
						nextAnnounceTime: "in 4 hours",
						lastScrapeTime: "1 hour ago",
						seederCount: "12",
						leecherCount: "32",
						downloadCount: "12345"
					)
				]
			)
		)
	}
}
