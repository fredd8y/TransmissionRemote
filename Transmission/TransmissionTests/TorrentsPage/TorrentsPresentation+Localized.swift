//
//  TorrentsPresentation+Localized.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 27/07/23.
//

import XCTest
import Transmission

class XCTorrentTestCase: XCTestCase {
	func anyTorrentWithError() -> Torrent {
		Torrent(
			name: "a name",
			error: 0,
			errorString: "an error",
			eta: 123456789,
			id: 1234,
			isFinished: false,
			percentDone: 0.76,
			rateDownload: 123456,
			rateUpload: 123456,
			totalSize: 1234567,
			status: .stopped
		)
	}
	
	func anyTorrentWithoutError() -> Torrent {
		Torrent(
			name: "a name",
			error: 0,
			errorString: "",
			eta: 123456789,
			id: 1234,
			isFinished: false,
			percentDone: 0.76,
			rateDownload: 123456,
			rateUpload: 123456,
			totalSize: 1234567,
			status: .stopped
		)
	}
}
