//
//  NetworkSettingsLocalizationTests.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 29/08/23.
//

import XCTest
import Transmission

final class NetworkSettingsLocalizationTests: XCTestCase {
	
	func test_localizedStrings_haveKeysAndValuesForAllSupportedLocalizations() {
		let table = "NetworkSettings"
		let bundle = Bundle(for: NetworkSettingsPagePresenter.self)
		
		assertLocalizedKeyAndValuesExist(in: bundle, table)
	}
	
}
