//
//  TorrentPresenterTests.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 19/07/23.
//

import XCTest
@testable import Transmission

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
	
	func test_viewModelStatus_stopped() {
		let viewModelStatus = TorrentPresenter.viewModelStatus(.stopped)
		
		XCTAssertEqual(viewModelStatus, .stopped)
	}
	
	func test_viewModelStatus_queuedVerifyLocalData() {
		let viewModelStatus = TorrentPresenter.viewModelStatus(.queuedVerifyLocalData)
		
		XCTAssertEqual(viewModelStatus, .running)
	}
	
	func test_viewModelStatus_verifyingLocalData() {
		let viewModelStatus = TorrentPresenter.viewModelStatus(.verifyingLocalData)
		
		XCTAssertEqual(viewModelStatus, .running)
	}
	
	func test_viewModelStatus_queuedDownload() {
		let viewModelStatus = TorrentPresenter.viewModelStatus(.queuedDownload)
		
		XCTAssertEqual(viewModelStatus, .running)
	}
	
	func test_viewModelStatus_downloading() {
		let viewModelStatus = TorrentPresenter.viewModelStatus(.downloading)
		
		XCTAssertEqual(viewModelStatus, .running)
	}
	
	func test_viewModelStatus_queuedToSeed() {
		let viewModelStatus = TorrentPresenter.viewModelStatus(.queuedToSeed)
		
		XCTAssertEqual(viewModelStatus, .running)
	}
	
	func test_viewModelStatus_seeding() {
		let viewModelStatus = TorrentPresenter.viewModelStatus(.seeding)
		
		XCTAssertEqual(viewModelStatus, .completed)
	}
	
	func test_viewModelStatus_unknown() {
		let viewModelStatus = TorrentPresenter.viewModelStatus(.unknown)
		
		XCTAssertEqual(viewModelStatus, .running)
	}
	
	func test_torrentStatusDescription_stopped() {
		let torrent = anyTorrentWithStatus(.stopped)
		
		let description = TorrentPresenter.torrentStatusDescription(torrent)
		
		XCTAssertEqual(description, TorrentPresenter.stopped)
	}
	
	func test_torrentStatusDescription_queuedVerifyLocalData() {
		let torrent = anyTorrentWithStatus(.queuedVerifyLocalData)
		
		let description = TorrentPresenter.torrentStatusDescription(torrent)
		
		XCTAssertEqual(description, TorrentPresenter.queuedToVerifyLocalData)
	}
	
	func test_torrentStatusDescription_verifyingLocalData() {
		let torrent = anyTorrentWithStatus(.verifyingLocalData)
		
		let description = TorrentPresenter.torrentStatusDescription(torrent)
		
		XCTAssertEqual(description, TorrentPresenter.verifyingLocalData)
	}
	
	func test_torrentStatusDescription_queuedToDownload() {
		let torrent = anyTorrentWithStatus(.queuedDownload)
		
		let description = TorrentPresenter.torrentStatusDescription(torrent)
		
		XCTAssertEqual(description, TorrentPresenter.queuedToDownload)
	}
	
	func test_torrentStatusDescription_downloading() {
		let torrent = anyTorrentWithStatus(.downloading)
		
		let description = TorrentPresenter.torrentStatusDescription(torrent)
		
		XCTAssertEqual(description, "\(TorrentPresenter.downloadCompletedIn) \(TorrentPresenter.relativeEta(torrent.eta))")
	}
	
	func test_torrentStatusDescription_queuedToSeed() {
		let torrent = anyTorrentWithStatus(.queuedToSeed)
		
		let description = TorrentPresenter.torrentStatusDescription(torrent)
		
		XCTAssertEqual(description, TorrentPresenter.queuedToSeed)
	}
	
	func test_torrentStatusDescription_seeding() {
		let torrent = anyTorrentWithStatus(.seeding)
		
		let description = TorrentPresenter.torrentStatusDescription(torrent)
		
		XCTAssertEqual(description, TorrentPresenter.seeding)
	}
	
	func test_torrentStatusDescription_unknown() {
		let torrent = anyTorrentWithStatus(.unknown)
		
		let description = TorrentPresenter.torrentStatusDescription(torrent)
		
		XCTAssertEqual(description, TorrentPresenter.unknown)
	}
	
}


