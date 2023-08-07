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
	
	func test_serverSectionHeader_isLocalized() {
		XCTAssertEqual(ServerDetailPagePresenter.serverSectionHeader, localized("SERVER_SECTION_HEADER", table: table))
	}
	
	func test_authenticationSectionHeader_isLocalized() {
		XCTAssertEqual(ServerDetailPagePresenter.authenticationSectionHeader, localized("AUTHENTICATION_SECTION_HEADER", table: table))
	}
	
	func test_namePlaceholder_isLocalized() {
		XCTAssertEqual(ServerDetailPagePresenter.namePlaceholder, localized("NAME_PLACEHOLDER", table: table))
	}
	
	func test_ipPlaceholder_isLocalized() {
		XCTAssertEqual(ServerDetailPagePresenter.ipPlaceholder, localized("IP_PLACEHOLDER", table: table))
	}
	
	func test_protocolPlaceholder_isLocalized() {
		XCTAssertEqual(ServerDetailPagePresenter.protocolPlaceholder, localized("PROTOCOL_PLACEHOLDER", table: table))
	}
	
	func test_portPlaceholder_isLocalized() {
		XCTAssertEqual(ServerDetailPagePresenter.portPlaceholder, localized("PORT_PLACEHOLDER", table: table))
	}
	
	func test_usernamePlaceholder_isLocalized() {
		XCTAssertEqual(ServerDetailPagePresenter.usernamePlaceholder, localized("USERNAME_PLACEHOLDER", table: table))
	}
	
	func test_passwordPlaceholder_isLocalized() {
		XCTAssertEqual(ServerDetailPagePresenter.passwordPlaceholder, localized("PASSWORD_PLACEHOLDER", table: table))
	}
	
	func test_saveButtonTitle_isLocalized() {
		XCTAssertEqual(ServerDetailPagePresenter.saveButtonTitle, localized("SAVE_BUTTON_TITLE", table: table))
	}
	
	func test_nameError_isLocalized() {
		XCTAssertEqual(ServerDetailPagePresenter.nameError, localized("NAME_ERROR", table: table))
	}
	
	func test_ipError_isLocalized() {
		XCTAssertEqual(ServerDetailPagePresenter.ipError, localized("IP_ERROR", table: table))
	}
	
	func test_portError_isLocalized() {
		XCTAssertEqual(ServerDetailPagePresenter.portError, localized("PORT_ERROR", table: table))
	}
	
	func test_usernameError_isLocalized() {
		XCTAssertEqual(ServerDetailPagePresenter.usernameError, localized("USERNAME_ERROR", table: table))
	}
	
	func test_passwordError_isLocalized() {
		XCTAssertEqual(ServerDetailPagePresenter.passwordError, localized("PASSWORD_ERROR", table: table))
	}
	
	func test_map_createsViewModel() {
		let title = "Server detail"
		let server = server()
		let serverId = UUID()
		
		let viewModel = ServerDetailPageViewModel(
			title: title,
			name: server.name,
			httpProtocol: server.httpProtocol,
			ip: server.ip,
			port: server.port.description,
			username: server.username,
			password: server.password,
			serverId: serverId
		)
		
		XCTAssertEqual(viewModel.title, title)
		XCTAssertEqual(viewModel.name, server.name)
		XCTAssertEqual(viewModel.httpProtocol, server.httpProtocol)
		XCTAssertEqual(viewModel.ip, server.ip)
		XCTAssertEqual(viewModel.port, server.port.description)
		XCTAssertEqual(viewModel.username, server.username)
		XCTAssertEqual(viewModel.password, server.password)
		XCTAssertEqual(viewModel.serverId, serverId)
	}
	
}
