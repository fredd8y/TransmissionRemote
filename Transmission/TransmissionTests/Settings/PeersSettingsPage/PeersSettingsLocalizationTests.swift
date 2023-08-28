//
//  PeersSettingsLocalizationTests.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 28/08/23.
//

import XCTest
import Transmission

final class PeersSettingsLocalizationTests: XCTestCase {
	
	func test_localizedStrings_haveKeysAndValuesForAllSupportedLocalizations() {
		let table = "PeersSettings"
		let bundle = Bundle(for: PeersSettingsPagePresenter.self)
		
		assertLocalizedKeyAndValuesExist(in: bundle, table)
	}
	
}
