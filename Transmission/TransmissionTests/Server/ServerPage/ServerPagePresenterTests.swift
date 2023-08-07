//
//  ServerPagePresenterTests.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 30/07/23.
//

import XCTest
import Transmission

final class ServerPagePresenterTests: XCTestCase {
	
	private let table = "Servers"
	
	func test_title_isLocalized() {
		XCTAssertEqual(ServerPagePresenter.title, localized("SERVERS_VIEW_TITLE", table: table))
	}
	
	func test_map_createsViewModel() {
		let currentSelectedServerId = UUID()
		let title = "Servers"
		let server1 = server()
		let server2 = server()
		let currentSelectedServer = server(currentSelectedServerId)
		
		let viewModel = ServerPagePresenter.map(
			title: title,
			servers: [server1, server2],
			currentSelectedServer: currentSelectedServer
		)
		
		XCTAssertEqual(viewModel.title, title)
		XCTAssertEqual(viewModel.servers, [
			ServerPresenter.map(server1),
			ServerPresenter.map(server2)
		])
		XCTAssertEqual(viewModel.currentSelectedServerId, currentSelectedServer.id)
	}
	
	// MARK: - Helpers
	
	private func server(_ id: UUID = UUID()) -> Server {
		Server(
			name: "a server",
			httpProtocol: .http,
			ip: "192.168.0.1",
			port: 9091,
			username: "a username",
			password: "a password",
			id: id
		)
	}
}
