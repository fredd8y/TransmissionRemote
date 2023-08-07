//
//  TorrentsPresenterTests.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 19/07/23.
//

import XCTest
import Transmission

final class TorrentsPresenterTests: XCTestCase {
	
	private let table = "Torrents"
	
	func test_title_isLocalized() {
		XCTAssertEqual(TorrentsPresenter.title, localized("TORRENTS_VIEW_TITLE", table: table))
	}
	
	func test_torrents_isLocalized() {
		XCTAssertEqual(TorrentsPresenter.torrents, localized("TORRENTS", table: table))
	}
	
	func test_torrent_isLocalized() {
		XCTAssertEqual(TorrentsPresenter.torrent, localized("TORRENT", table: table))
	}
	
	func test_username_isLocalized() {
		XCTAssertEqual(TorrentsPresenter.username, localized("USERNAME", table: table))
	}
	
	func test_password_isLocalized() {
		XCTAssertEqual(TorrentsPresenter.password, localized("PASSWORD", table: table))
	}
	
	func test_credentialRequested_isLocalized() {
		XCTAssertEqual(TorrentsPresenter.credentialRequested, localized("CREDENTIAL_NEEDED_TITLE", table: table))
	}
	
	func test_ok_isLocalized() {
		XCTAssertEqual(TorrentsPresenter.ok, localized("OK", table: table))
	}
	
	func test_undefinedError_isLocalized() {
		XCTAssertEqual(TorrentsPresenter.undefinedError, localized("UNDEFINED_ERROR", table: table))
	}
	
	func test_map_createsViewModel() {
		let title = "Title"
		let uploadSpeed = 1234576
		let downloadSpeed = 1234567
		let torrent1 = anyTorrentWithoutError()
		let torrent2 = anyTorrentWithError()
		let torrents = [torrent1, torrent2]
		
		let viewModel = TorrentsPresenter.map(
			title: title,
			error: nil,
			uploadSpeed: uploadSpeed,
			downloadSpeed: downloadSpeed,
			torrents: torrents
		)
		
		XCTAssertEqual(viewModel.title, title)
		XCTAssertEqual(viewModel.downloadSpeed, "1,23 MB/s")
		XCTAssertEqual(viewModel.uploadSpeed, "1,23 MB/s")
		XCTAssertEqual(viewModel.torrents, [
			TorrentPresenter.map(torrent1),
			TorrentPresenter.map(torrent2)
		])
		
	}
}

