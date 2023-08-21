//
//  TorrentTrackersLocalizationTests.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 21/08/23.
//

import XCTest
import Transmission

final class TorrentTrackersLocalizationTests: XCTestCase {
	
	func test_localizedStrings_haveKeysAndValuesForAllSupportedLocalizations() {
		let table = "TorrentTrackers"
		let bundle = Bundle(for: TorrentTrackersPagePresenter.self)
		
		assertLocalizedKeyAndValuesExist(in: bundle, table)
	}
	
}
