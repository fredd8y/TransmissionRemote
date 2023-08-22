//
//  TorrentsSettingsPresenterTests.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 22/08/23.
//

import XCTest
import Transmission

final class TorrentsSettingsPresenterTests: XCTestCase {
	
	private let table = "TorrentsSettings"
	
	func test_title_isLocalized() {
		XCTAssertEqual(TorrentsSettingsPagePresenter.title, localized("TORRENTS_SETTINGS_PAGE_TITLE", table: table))
	}
	
	func test_map_createsViewModel() {
		let downloadDir = "a download dir"
		let startAddedTorrents = true
		let renamePartialFiles = true
		let seedRatioLimited = true
		let seedRatioLimit = 2
		let idleSeedingLimitedEnabled = true
		let idleSeedingLimit = 30
		
		let viewModel = TorrentsSettingsPagePresenter.map(
			downloadDir: downloadDir,
			startAddedTorrents: startAddedTorrents,
			renamePartialFiles: renamePartialFiles,
			seedRatioLimited: seedRatioLimited,
			seedRatioLimit: seedRatioLimit,
			idleSeedingLimitedEnabled: idleSeedingLimitedEnabled,
			idleSeedingLimit: idleSeedingLimit
		)
		
		XCTAssertEqual(downloadDir, viewModel.downloadDir)
		XCTAssertEqual(startAddedTorrents, viewModel.startAddedTorrents)
		XCTAssertEqual(renamePartialFiles, viewModel.renamePartialFiles)
		XCTAssertEqual(seedRatioLimited, viewModel.seedRatioLimited)
		XCTAssertEqual(seedRatioLimit.description, viewModel.seedRatioLimit)
		XCTAssertEqual(idleSeedingLimitedEnabled, viewModel.idleSeedingLimitedEnabled)
		XCTAssertEqual(idleSeedingLimit.description, viewModel.idleSeedingLimit)
	}
}
