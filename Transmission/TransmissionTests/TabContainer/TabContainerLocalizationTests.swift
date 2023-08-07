//
//  TabContainerLocalizationTests.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 04/08/23.
//

import XCTest
import Transmission

final class TabContainerLocalizationTests: XCTestCase {
	
	func test_localizedStrings_haveKeysAndValuesForAllSupportedLocalizations() {
		let table = "TabContainer"
		let bundle = Bundle(for: TabContainerPresenter.self)
		
		assertLocalizedKeyAndValuesExist(in: bundle, table)
	}
	
}
