//
//  TorrentPresenterTests.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 19/07/23.
//

import XCTest
import Transmission

final class TorrentPresenterTests: XCTestCase {
	func test_eta_isLocalized() {
		XCTAssertEqual(TorrentPresenter.eta, localized("TORRENT_ITEM_ETA"))
	}
	
	func test_of_isLocalized() {
		XCTAssertEqual(TorrentPresenter.of, localized("TORRENT_ITEM_OF_PREPOSITION"))
	}
	
	func test_map_createsViewModelwithNilError() {
		let torrent = Torrent(
			name: "a name",
			error: 0,
			errorString: "",
			eta: 123456789,
			id: 1234,
			isFinished: false,
			percentDone: 0.76,
			rateDownload: 123456,
			totalSize: 1234567
		)
		
		let viewModel = TorrentPresenter.map(torrent)
		
		XCTAssertEqual(viewModel.error, nil)
	}
	
	func test_map_createsViewModelWithError() {
		let torrent = Torrent(
			name: "a name",
			error: 0,
			errorString: "an error",
			eta: 123456789,
			id: 1234,
			isFinished: false,
			percentDone: 0.76,
			rateDownload: 123456,
			totalSize: 1234567
		)
		
		let viewModel = TorrentPresenter.map(torrent)
		
		XCTAssertEqual(viewModel.error, torrent.errorString)
	}
}


