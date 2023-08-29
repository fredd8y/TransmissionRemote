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
	
	func test_downloadingHeader_isLocalized() {
		XCTAssertEqual(TorrentsSettingsPagePresenter.downloadingHeader, localized("DOWNLOADING_HEADER", table: table))
	}
	
	func test_downloadTo_isLocalized() {
		XCTAssertEqual(TorrentsSettingsPagePresenter.downloadTo, localized("DOWNLOAD_TO", table: table))
	}
	
	func test_startWhenAdded_isLocalized() {
		XCTAssertEqual(TorrentsSettingsPagePresenter.startWhenAdded, localized("START_WHEN_ADDED", table: table))
	}
	
	func test_incompleteFileNamesExtension_isLocalized() {
		XCTAssertEqual(TorrentsSettingsPagePresenter.incompleteFileNamesExtension, localized("INCOMPLETE_FILE_NAMES_EXTENSION", table: table))
	}
	
	func test_seedingHeader_isLocalized() {
		XCTAssertEqual(TorrentsSettingsPagePresenter.seedingHeader, localized("SEEDING_HEADER", table: table))
	}
	
	func test_stopSeedingAtRatio_isLocalized() {
		XCTAssertEqual(TorrentsSettingsPagePresenter.stopSeedingAtRatio, localized("STOP_SEEDING_AT_RATIO", table: table))
	}
	
	func test_mustBeANumber_isLocalized() {
		XCTAssertEqual(TorrentsSettingsPagePresenter.mustBeANumber, localized("MUST_BE_A_NUMBER", table: table))
	}
	
	func test_mustBeADirectory_isLocalized() {
		XCTAssertEqual(TorrentsSettingsPagePresenter.mustBeADirectory, localized("MUST_BE_A_DIRECTORY", table: table))
	}
	
	func test_stopSeedingIfIdle_isLocalized() {
		XCTAssertEqual(TorrentsSettingsPagePresenter.stopSeedingIfIdle, localized("STOP_SEEDING_IF_IDLE", table: table))
	}
	
	func test_confirmButtonTitle_isLocalized() {
		XCTAssertEqual(TorrentsSettingsPagePresenter.confirmButtonTitle, localized("CONFIRM_BUTTON_TITLE", table: table))
	}
	
	func test_map_createsViewModel() {
		let downloadDir = "a download dir"
		let startAddedTorrents = true
		let renamePartialFiles = true
		let seedRatioLimited = true
		let seedRatioLimit = 2
		let idleSeedingLimitEnabled = true
		let idleSeedingLimit = 30
		
		let viewModel = TorrentsSettingsPagePresenter.map(TorrentsSettings(
			downloadDir: downloadDir,
			startAddedTorrents: startAddedTorrents,
			renamePartialFiles: renamePartialFiles,
			seedRatioLimited: seedRatioLimited,
			seedRatioLimit: seedRatioLimit,
			idleSeedingLimitEnabled: idleSeedingLimitEnabled,
			idleSeedingLimit: idleSeedingLimit
		))
		
		XCTAssertEqual(downloadDir, viewModel.downloadDir)
		XCTAssertEqual(startAddedTorrents, viewModel.startAddedTorrents)
		XCTAssertEqual(renamePartialFiles, viewModel.renamePartialFiles)
		XCTAssertEqual(seedRatioLimited, viewModel.seedRatioLimited)
		XCTAssertEqual(seedRatioLimit.description, viewModel.seedRatioLimit)
		XCTAssertEqual(idleSeedingLimitEnabled, viewModel.idleSeedingLimitEnabled)
		XCTAssertEqual(idleSeedingLimit.description, viewModel.idleSeedingLimit)
	}
	
}
