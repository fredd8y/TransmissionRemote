//
//  TorrentsSettingsLocalizationTests.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 22/08/23.
//

import XCTest
import Transmission

final class TorrentsSettingsLocalizationTests: XCTestCase {
	
	func test_localizedStrings_haveKeysAndValuesForAllSupportedLocalizations() {
		let table = "TorrentsSettings"
		let bundle = Bundle(for: TorrentsSettingsPagePresenter.self)
		
		assertLocalizedKeyAndValuesExist(in: bundle, table)
	}
	
}
