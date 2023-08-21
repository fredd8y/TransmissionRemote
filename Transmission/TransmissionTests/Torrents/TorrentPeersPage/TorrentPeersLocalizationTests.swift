//
//  TorrentPeersLocalizationTests.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 20/08/23.
//

import XCTest
import Transmission

final class TorrentPeersLocalizationTests: XCTestCase {
	
	func test_localizedStrings_haveKeysAndValuesForAllSupportedLocalizations() {
		let table = "TorrentPeers"
		let bundle = Bundle(for: TorrentPeersPagePresenter.self)
		
		assertLocalizedKeyAndValuesExist(in: bundle, table)
	}
	
}

