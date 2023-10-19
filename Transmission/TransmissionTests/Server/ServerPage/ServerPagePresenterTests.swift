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
	
	func test_deleteItemActionTitle_isLocalized() {
		XCTAssertEqual(ServerPagePresenter.deleteItemActionTitle, localized("SERVER_PAGE_ITEM_DELETE_ACTION", table: table))
	}
	
	func test_emptyMessage_isLocalized() {
		XCTAssertEqual(ServerPagePresenter.serverPageEmptyMessage, localized("SERVER_PAGE_EMPTY_MESSAGE", table: table))
	}
	
	func test_alertErrorTitle_isLocalized() {
		XCTAssertEqual(ServerPagePresenter.alertErrorTitle, localized("SERVER_PAGE_ALERT_ERROR_TITLE", table: table))
	}
	
	func test_ok_isLocalized() {
		XCTAssertEqual(ServerPagePresenter.ok, localized("SERVER_PAGE_OK", table: table))
	}
	
	func test_deleteServerError_isLocalized() {
		XCTAssertEqual(ServerPagePresenter.ok, localized("SERVER_PAGE_DELETE_SERVER_ERROR", table: table))
	}
	
	func test_loadingDataError_isLocalized() {
		XCTAssertEqual(ServerPagePresenter.ok, localized("SERVER_PAGE_LOADING_DATA_ERROR", table: table))
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
