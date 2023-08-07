//
//  TorrentsPresenterTests.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 19/07/23.
//

import XCTest
import Transmission

final class TorrentsPresenterTests: XCTestCase {
	
	func test_title_isLocalized() {
		XCTAssertEqual(TorrentsPresenter.title, localized("TORRENTS_VIEW_TITLE"))
	}
	
	func test_map_createsViewModelWithNoError() {
		let title = "Title"
		let uploadSpeed = 1234576
		let downloadSpeed = 1234567
		let torrent1 = anyTorrentWithoutError()
		let torrent2 = anyTorrentWithError()
		let torrents = [torrent1, torrent2]
		
		let viewModel = TorrentsPresenter.map(title: title, uploadSpeed: uploadSpeed, downloadSpeed: downloadSpeed, torrents: torrents)
		
		XCTAssertEqual(viewModel.title, title)
		XCTAssertEqual(viewModel.downloadSpeed, "1,24 MB/s")
		XCTAssertEqual(viewModel.uploadSpeed, "1,24 MB/s")
		XCTAssertEqual(viewModel.torrents, [
			TorrentPresenter.map(torrent1),
			TorrentPresenter.map(torrent2)
		])
		
	}
}

