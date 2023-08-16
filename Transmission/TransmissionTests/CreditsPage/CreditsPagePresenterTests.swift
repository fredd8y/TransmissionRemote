//
//  CreditsPagePresenterTests.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 16/08/23.
//

import XCTest
import Transmission

final class CreditsPagePresenterTests: XCTestCase {
	
	private let table = "CreditsPage"
	
	func test_title_isLocalized() {
		XCTAssertEqual(CreditsPagePresenter.title, localized("CREDITS_PAGE_TITLE", table: table))
	}
	
	func test_turtleIconCredits_isLocalized() {
		XCTAssertEqual(CreditsPagePresenter.turtleIconCredit, localized("TURTLE_ICON_CREDITS", table: table))
	}
	
}
