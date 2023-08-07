//
//  ServerPresenterTests.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 30/07/23.
//

import XCTest
import Transmission

final class ServerPresenterTests: XCTestCase {
	
	func test_map_createsViewModel() {
		let title = "a title"
		let url = "http://anyurl.com"
		let id = UUID()
		
		let viewModel = ServerViewModel(
			title: title,
			url: url,
			id: id
		)
		
		XCTAssertEqual(viewModel.title, title)
		XCTAssertEqual(viewModel.url, url)
		XCTAssertEqual(viewModel.id, id)
	}
	
}
