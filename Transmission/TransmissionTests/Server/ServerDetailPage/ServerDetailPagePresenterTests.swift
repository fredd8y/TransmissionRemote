//
//  ServerDetailPagePresenterTests.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 30/07/23.
//

import XCTest
import Transmission

final class ServerDetailPagePresenterTests: XCServerTestCase {
	
	private let table = "ServerDetails"
	
	func test_title_isLocalized() {
		XCTAssertEqual(ServerDetailPagePresenter.title, localized("SERVERS_DETAIL_VIEW_TITLE", table: table))
	}
	
	func test_map_createsViewModel() {
		let title = "Server detail"
		let server = server()
		
		let viewModel = ServerDetailPageViewModel(
			title: title,
			name: server.name,
			protocol: server.httpProtocol.rawValue,
			ip: server.ip,
			port: server.port,
			username: server.username,
			password: server.password
		)
		
		XCTAssertEqual(viewModel.title, title)
		XCTAssertEqual(viewModel.name, server.name)
		XCTAssertEqual(viewModel.protocol, server.httpProtocol.rawValue)
		XCTAssertEqual(viewModel.ip, server.ip)
		XCTAssertEqual(viewModel.port, server.port)
		XCTAssertEqual(viewModel.username, server.username)
		XCTAssertEqual(viewModel.password, server.password)
	}
	
}
