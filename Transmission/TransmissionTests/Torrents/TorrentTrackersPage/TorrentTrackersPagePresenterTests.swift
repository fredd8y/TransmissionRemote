//
//  TorrentTrackersPagePresenterTests.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 21/08/23.
//

import XCTest
@testable import Transmission

final class TorrentTrackersPagePresenterTests: XCTorrentTestCase {
	
	private let table = "TorrentTrackers"
	
	func test_title_isLocalized() {
		XCTAssertEqual(TorrentTrackersPagePresenter.title, localized("TITLE", table: table))
	}
	
	func test_lastAnnounce_isLocalized() {
		XCTAssertEqual(TorrentTrackersPagePresenter.lastAnnounce, localized("LAST_ANNOUNCE", table: table))
	}
	
	func test_nextAnnounce_isLocalized() {
		XCTAssertEqual(TorrentTrackersPagePresenter.nextAnnounce, localized("NEXT_ANNOUNCE", table: table))
	}
	
	func test_lastScrape_isLocalized() {
		XCTAssertEqual(TorrentTrackersPagePresenter.lastScrape, localized("LAST_SCRAPE", table: table))
	}
	
	func test_seeders_isLocalized() {
		XCTAssertEqual(TorrentTrackersPagePresenter.seeders, localized("SEEDERS", table: table))
	}
	
	func test_leechers_isLocalized() {
		XCTAssertEqual(TorrentTrackersPagePresenter.leechers, localized("LEECHERS", table: table))
	}
	
	func test_downloads_isLocalized() {
		XCTAssertEqual(TorrentTrackersPagePresenter.downloads, localized("DOWNLOADS", table: table))
	}
	
	func test_relativeEta() {
		let oneHour = 3600
		
		let receivedEta = TorrentTrackersPagePresenter.relativeEta(oneHour, locale: Locale(identifier: "en_US_POSIX"), calendar: Calendar(identifier: .gregorian))
		
		XCTAssertEqual(receivedEta, "in 1 hour")
	}
	
	func test_map_createsViewModel() {
		let id = 1
		let host = "host"
		let lastAnnounceTime = 1692361373
		let lastAnnouncePeerCount = 1692361373
		let nextAnnounceTime = 1692861373
		let lastScrapeTime = 1692361373
		let seederCount = 123
		let leecherCount = 321
		let downloadCount = 12345
		
		let viewModel = TorrentTrackersPagePresenter.map(
			[
				TorrentTracker(
					id: id,
					host: host,
					lastAnnounceTime: lastAnnounceTime,
					lastAnnouncePeerCount: lastAnnouncePeerCount,
					nextAnnounceTime: nextAnnounceTime,
					lastScrapeTime: lastScrapeTime,
					seederCount: seederCount,
					leecherCount: leecherCount,
					downloadCount: downloadCount
				)
			],
            locale: Locale(identifier: "en_US_POSIX"),
			referenceDate: Date(timeIntervalSince1970: 1692367725)
		)

		let tracker = viewModel.trackers.first!
		
		XCTAssertEqual(tracker.id, id)
		XCTAssertEqual(tracker.host, host)
		XCTAssertEqual(tracker.lastAnnounceTime, "1 hour ago")
		XCTAssertEqual(tracker.lastAnnouncePeerCount, "1 hour ago")
		XCTAssertEqual(tracker.nextAnnounceTime, "in 5 days")
		XCTAssertEqual(tracker.lastScrapeTime, "1 hour ago")
		XCTAssertEqual(tracker.seederCount, "123")
		XCTAssertEqual(tracker.leecherCount, "321")
		XCTAssertEqual(tracker.downloadCount, "12345")
	}
	
}
