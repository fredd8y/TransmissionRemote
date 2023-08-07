//
//  SettingsLocalizationTests.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 27/07/23.
//

import XCTest
import Transmission

final class SettingsLocalizationTests: XCTestCase {

	func test_localizedStrings_haveKeysAndValuesForAllSupportedLocalizations() {
		let table = "Settings"
		let bundle = Bundle(for: SettingsPresenter.self)
		
		assertLocalizedKeyAndValuesExist(in: bundle, table)
	}

}
