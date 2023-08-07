//
//  ServerLocalizationTests.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 30/07/23.
//

import XCTest
import Transmission

final class ServerLocalizationTests: XCTestCase {
	
	func test_localizedStrings_haveKeysAndValuesForAllSupportedLocalizations() {
		let table = "Servers"
		let bundle = Bundle(for: ServerPagePresenter.self)
		
		assertLocalizedKeyAndValuesExist(in: bundle, table)
	}
	
}
