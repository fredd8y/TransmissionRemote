//
//  TorrentDetailPresenterTests.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 17/08/23.
//

import XCTest
@testable import Transmission

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
	
	func test_name_isLocalized() {
		XCTAssertEqual(TorrentDetailPresenter.name, localized("NAME", table: table))
	}
	
	func test_percentageCompleted_isLocalized() {
		XCTAssertEqual(TorrentDetailPresenter.percentageCompleted, localized("AVAILABILITY", table: table))
	}
	
	func test_uploaded_isLocalized() {
		XCTAssertEqual(TorrentDetailPresenter.uploaded, localized("UPLOADED", table: table))
	}
	
	func test_downloaded_isLocalized() {
		XCTAssertEqual(TorrentDetailPresenter.downloaded, localized("DOWNLOADED", table: table))
	}
	
	func test_state_isLocalized() {
		XCTAssertEqual(TorrentDetailPresenter.state, localized("STATE", table: table))
	}
	
	func test_runningTime_isLocalized() {
		XCTAssertEqual(TorrentDetailPresenter.runningTime, localized("RUNNING_TIME", table: table))
	}
	
	func test_remainingTime_isLocalized() {
		XCTAssertEqual(TorrentDetailPresenter.remainingTime, localized("REMAINING_TIME", table: table))
	}
	
	func test_lastActivity_isLocalized() {
		XCTAssertEqual(TorrentDetailPresenter.lastActivity, localized("LAST_ACTIVITY", table: table))
	}
	
	func test_error_isLocalized() {
		XCTAssertEqual(TorrentDetailPresenter.error, localized("ERROR", table: table))
	}
	
	func test_size_isLocalized() {
		XCTAssertEqual(TorrentDetailPresenter.size, localized("SIZE", table: table))
	}
	
	func test_location_isLocalized() {
		XCTAssertEqual(TorrentDetailPresenter.location, localized("LOCATION", table: table))
	}
	
	func test_hash_isLocalized() {
		XCTAssertEqual(TorrentDetailPresenter.hash, localized("HASH", table: table))
	}
	
	func test_privacy_isLocalized() {
		XCTAssertEqual(TorrentDetailPresenter.privacy, localized("PRIVACY", table: table))
	}
	
	func test_title_isLocalized() {
		XCTAssertEqual(TorrentDetailPresenter.title, localized("TITLE", table: table))
	}
	
	func test_activitySectionHeader_isLocalized() {
		XCTAssertEqual(TorrentDetailPresenter.activitySectionHeader, localized("ACTIVITY_SECTION_HEADER", table: table))
	}
	
	func test_detailsSectionHeader_isLocalized() {
		XCTAssertEqual(TorrentDetailPresenter.detailsSectionHeader, localized("DETAILS_SECTION_HEADER", table: table))
	}
	
	func test_map_createsViewModel() {
		let name = "a name"
		let percentageAvailability = 0.97
		let uploaded = 1234567
		let ratio = 0.19
		let downloaded = 1234567
		let state = Status.downloading
		let startDate = 1234567
		let eta = 1234567
		let lastActivity = 1234567
		let error = "any error"
		let size = 1234567
		let location = "any url"
		let hash = "qwertyuiop1234567890"
		let isPrivate = true
		
		let viewModel = TorrentDetailPresenter.map(TorrentDetail(
			name: name,
			percentageAvailability: percentageAvailability,
			uploaded: uploaded,
			ratio: ratio,
			downloaded: downloaded,
			state: state,
			startDate: startDate,
			eta: eta,
			lastActivity: lastActivity,
			error: error,
			size: size,
			location: location,
			hash: hash,
			isPrivate: isPrivate
		))
		
		XCTAssertEqual(viewModel.name, name)
		XCTAssertEqual(viewModel.percentageCompleted, "97,00%")
		XCTAssertEqual(viewModel.uploaded, "1,18 MB")
		XCTAssertEqual(viewModel.ratio, "0,19")
		XCTAssertEqual(viewModel.downloaded, "1,18 MB")
		XCTAssertEqual(viewModel.state, "Downloading")
		XCTAssertEqual(viewModel.runningTime, "in 2 weeks")
		XCTAssertEqual(viewModel.remainingTime, "Download will be completed in 2 weeks")
		XCTAssertEqual(viewModel.lastActivity, "in 2 weeks")
		XCTAssertEqual(viewModel.error, error)
		XCTAssertEqual(viewModel.size, "1,18 MB")
		XCTAssertEqual(viewModel.location, location)
		XCTAssertEqual(viewModel.hash, hash)
		XCTAssertEqual(viewModel.privacy, "Private torrent")
	}
}
