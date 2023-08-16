//
//  CreditsPageTests.swift
//  TransmissioniOSTests
//
//  Created by Federico Arvat on 16/08/23.
//

import XCTest
@testable import Transmission
@testable import TransmissioniOS

class CreditsPageTests: XCTestCase {
	func test_creditssPage() {
		let sut = makeSUT()
		
		assert(snapshot: sut.snapshot(.iPhone13(style: .light)), named: "CREDITS_PAGE_light")
		assert(snapshot: sut.snapshot(.iPhone13(style: .dark)), named: "CREDITS_PAGE_dark")
		assert(snapshot: sut.snapshot(.iPhone13(style: .light, contentSize: .extraExtraExtraLarge)), named: "CREDITS_PAGE_light_extraExtraExtraLarge")
	}
	
	// MARK: - Helpers
	
	private func makeSUT() -> CreditsPage {
		CreditsPage()
	}
}
