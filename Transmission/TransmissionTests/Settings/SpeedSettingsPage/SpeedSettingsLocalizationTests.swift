//
//  SpeedSettingsLocalizationTests.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 25/08/23.
//

import XCTest
import Transmission

final class SpeedSettingsLocalizationTests: XCTestCase {
	
	func test_localizedStrings_haveKeysAndValuesForAllSupportedLocalizations() {
		let table = "SpeedSettings"
		let bundle = Bundle(for: SpeedSettingsPagePresenter.self)
		
		assertLocalizedKeyAndValuesExist(in: bundle, table)
	}
	
}
