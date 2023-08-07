//
//  ServerPagePresenterTests.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 30/07/23.
//

import XCTest
import Transmission

final class ServerPagePresenterTests: XCServerTestCase {
	
	private let table = "Servers"
	
	func test_title_isLocalized() {
		XCTAssertEqual(ServerPagePresenter.title, localized("SERVERS_VIEW_TITLE", table: table))
	}
	
	func test_editItemActionTitle_isLocalized() {
		XCTAssertEqual(ServerPagePresenter.editItemActionTitle, localized("SERVER_PAGE_ITEM_EDIT_ACTION", table: table))
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
}
