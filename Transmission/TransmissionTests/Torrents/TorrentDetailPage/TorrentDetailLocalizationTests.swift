//
//  TorrentDetailLocalizationTests.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 17/08/23.
//

import XCTest
import Transmission

final class TorrentDetailLocalizationTests: XCTestCase {
	
	func test_localizedStrings_haveKeysAndValuesForAllSupportedLocalizations() {
		let table = "TorrentDetail"
		let bundle = Bundle(for: TorrentDetailPresenter.self)
		
		assertLocalizedKeyAndValuesExist(in: bundle, table)
	}
	
}
