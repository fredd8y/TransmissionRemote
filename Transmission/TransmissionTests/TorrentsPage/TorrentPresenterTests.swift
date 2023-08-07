//
//  TorrentPresenterTests.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 19/07/23.
//

import XCTest
import Transmission

final class TorrentPresenterTests: XCTorrentTestCase {
	
	private let table = "Torrents"
	
	func test_of_isLocalized() {
		XCTAssertEqual(TorrentPresenter.of, localized("TORRENT_ITEM_OF_PREPOSITION", table: table))
	}
	
	func test_downloadCompletedIn_isLocalized() {
		XCTAssertEqual(TorrentPresenter.downloadCompletedIn, localized("DOWNLOAD_COMPLETED_IN", table: table))
	}
	
	func test_stopped_isLocalized() {
		XCTAssertEqual(TorrentPresenter.stopped, localized("STOPPED", table: table))
	}
	
	func test_verifyingLocalData_isLocalized() {
		XCTAssertEqual(TorrentPresenter.verifyingLocalData, localized("VERIFYING_LOCAL_DATA", table: table))
	}
	
	func test_queuedToVerifyLocalData_isLocalized() {
		XCTAssertEqual(TorrentPresenter.queuedToVerifyLocalData, localized("QUEUED_TO_VERIFY_LOCAL_DATA", table: table))
	}
	
	func test_queuedToDownload_isLocalized() {
		XCTAssertEqual(TorrentPresenter.queuedToDownload, localized("QUEUED_TO_DOWNLOAD", table: table))
	}
	
	func test_queuedToSeed_isLocalized() {
		XCTAssertEqual(TorrentPresenter.queuedToSeed, localized("QUEUED_TO_SEED", table: table))
	}
	
	func test_seeding_isLocalized() {
		XCTAssertEqual(TorrentPresenter.seeding, localized("SEEDING", table: table))
	}
	
	func test_unknown_isLocalized() {
		XCTAssertEqual(TorrentPresenter.unknown, localized("UNKNOWN_STATUS", table: table))
	}
	
	func test_map_createsViewModelWithNilError() {
		let torrent = anyTorrentWithoutError()
		
		let viewModel = TorrentPresenter.map(torrent)
		
		XCTAssertEqual(viewModel.error, nil)
	}
	
	func test_map_createsViewModelWithError() {
		let torrent = anyTorrentWithError()
		
		let viewModel = TorrentPresenter.map(torrent)
		
		XCTAssertEqual(viewModel.error, torrent.errorString)
	}
}


