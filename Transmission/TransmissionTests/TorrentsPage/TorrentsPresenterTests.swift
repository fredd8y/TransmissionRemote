//
//  TorrentsPresenterTests.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 19/07/23.
//

import XCTest
import Transmission

final class TorrentsPresenterTests: XCTorrentTestCase {
	
	private let table = "Torrents"
	
	func test_title_isLocalized() {
		XCTAssertEqual(TorrentsPagePresenter.title, localized("TORRENTS_VIEW_TITLE", table: table))
	}
	
	func test_torrents_isLocalized() {
		XCTAssertEqual(TorrentsPagePresenter.torrents, localized("TORRENTS", table: table))
	}
	
	func test_torrent_isLocalized() {
		XCTAssertEqual(TorrentsPagePresenter.torrent, localized("TORRENT", table: table))
	}
	
	func test_credentialRequired_isLocalized() {
		XCTAssertEqual(TorrentsPagePresenter.credentialRequired, localized("CREDENTIAL_NEEDED_TITLE", table: table))
	}
	
	func test_ok_isLocalized() {
		XCTAssertEqual(TorrentsPagePresenter.ok, localized("OK", table: table))
	}
	
	func test_undefinedError_isLocalized() {
		XCTAssertEqual(TorrentsPagePresenter.undefinedError, localized("UNDEFINED_ERROR", table: table))
	}
	
	func test_serverNotSet_isLocalized() {
		XCTAssertEqual(TorrentsPagePresenter.serverNotSet, localized("SERVER_NOT_SET", table: table))
	}
	
	func test_map_createsViewModel() {
		let title = "Title"
		let error = "a error"
		let uploadSpeed = 1234576
		let downloadSpeed = 1234567
		let torrent1 = anyTorrentWithoutError()
		let torrent2 = anyTorrentWithError()
		let torrents = [torrent1, torrent2]
		let emptyMessage = "a message"
		let alertMessage = "alert message"
		let alertMessageVisibile = false
		
		let viewModel = TorrentsPagePresenter.map(
			title: title,
			error: error,
			uploadSpeed: uploadSpeed,
			downloadSpeed: downloadSpeed,
			torrents: torrents,
			emptyMessage: emptyMessage,
			alertMessage: alertMessage,
			alertMessageVisible: alertMessageVisibile
		)
		
		XCTAssertEqual(viewModel.title, title)
		XCTAssertEqual(viewModel.error, error)
		XCTAssertEqual(viewModel.downloadSpeed, "1,23 MB/s")
		XCTAssertEqual(viewModel.uploadSpeed, "1,23 MB/s")
		XCTAssertEqual(viewModel.torrents, [
			TorrentPresenter.map(torrent1),
			TorrentPresenter.map(torrent2)
		])
		XCTAssertEqual(viewModel.emptyMessage, emptyMessage)
		XCTAssertEqual(viewModel.alertMessage, alertMessage)
		XCTAssertEqual(viewModel.alertMessageVisible, alertMessageVisibile)
	}
}

