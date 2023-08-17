//
//  TorrentDetailPresenterTests.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 17/08/23.
//

import XCTest
import Transmission

final class TorrentDetailPresenterTests: XCTorrentTestCase {
	
	private let table = "TorrentDetail"
	
	func test_downloadCompletedIn_isLocalized() {
		XCTAssertEqual(TorrentDetailPresenter.downloadCompletedIn, localized("DOWNLOAD_COMPLETED_IN", table: table))
	}
	
	func test_privateTorrent_isLocalized() {
		XCTAssertEqual(TorrentDetailPresenter.privateTorrent, localized("PRIVATE_TORRENT", table: table))
	}
	
	func test_publicTorrent_isLocalized() {
		XCTAssertEqual(TorrentDetailPresenter.publicTorrent, localized("PUBLIC_TORRENT", table: table))
	}
	
	func test_stopped_isLocalized() {
		XCTAssertEqual(TorrentDetailPresenter.stopped, localized("STOPPED", table: table))
	}
	
	func test_queuedVerifyLocalData_isLocalized() {
		XCTAssertEqual(TorrentDetailPresenter.queuedVerifyLocalData, localized("QUEUED_VERIFY_LOCAL_DATA", table: table))
	}
	
	func test_verifyingLocalData_isLocalized() {
		XCTAssertEqual(TorrentDetailPresenter.verifyingLocalData, localized("VERIFYING_LOCAL_DATA", table: table))
	}
	
	func test_queuedDownload_isLocalized() {
		XCTAssertEqual(TorrentDetailPresenter.queuedDownload, localized("QUEUED_DOWNLOAD", table: table))
	}
	
	func test_downloading_isLocalized() {
		XCTAssertEqual(TorrentDetailPresenter.downloading, localized("DOWNLOADING", table: table))
	}
	
	func test_queuedToSeed_isLocalized() {
		XCTAssertEqual(TorrentDetailPresenter.queuedToSeed, localized("QUEUED_TO_SEED", table: table))
	}
	
	func test_seeding_isLocalized() {
		XCTAssertEqual(TorrentDetailPresenter.seeding, localized("SEEDING", table: table))
	}
	
	func test_unknown_isLocalized() {
		XCTAssertEqual(TorrentDetailPresenter.unknown, localized("UNKNOWN", table: table))
	}
	
}
