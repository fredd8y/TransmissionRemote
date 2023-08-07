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
	
	func test_server_createsUrl() {
		let server = Server(
			name: "a name",
			httpProtocol: .http,
			ip: "192.168.1.1",
			port: 9091,
			id: UUID()
		)
		
		XCTAssertEqual(server.url, "http://192.168.1.1:9091")
	}
	
}
