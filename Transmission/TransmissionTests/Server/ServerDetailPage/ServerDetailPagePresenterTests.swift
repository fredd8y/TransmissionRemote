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
	
	func test_map_createsViewModel() {
		let title = "Server detail"
		let server = server()
		let serverSectionHeader = "Server"
		let authenticationSectionHeader = "Authentication"
		let namePlaceholder = "Name"
		let saveButtonTitle = "Save"
		let protocolPlaceholder = "Protocol"
		let ipPlaceholder = "IP"
		let portPlaceholder = "Port"
		let usernamePlaceholder = "Username"
		let passwordPlaceholder = "Password"
		let serverId = UUID()
		
		
		let viewModel = ServerDetailPageViewModel(
			serverSectionHeader: serverSectionHeader,
			authenticationSectionHeader: authenticationSectionHeader,
			title: title,
			saveButtonTitle: saveButtonTitle,
			name: server.name,
			namePlaceholder: namePlaceholder,
			httpProtocol: server.httpProtocol,
			protocolPlaceholder: protocolPlaceholder,
			ip: server.ip,
			ipPlaceholder: ipPlaceholder,
			port: server.port.description,
			portPlaceholder: portPlaceholder,
			username: server.username,
			usernamePlaceholder: usernamePlaceholder,
			password: server.password,
			passwordPlaceholder: passwordPlaceholder,
			serverId: serverId
		)
		
		XCTAssertEqual(viewModel.serverSectionHeader, serverSectionHeader)
		XCTAssertEqual(viewModel.authenticationSectionHeader, authenticationSectionHeader)
		XCTAssertEqual(viewModel.title, title)
		XCTAssertEqual(viewModel.name, server.name)
		XCTAssertEqual(viewModel.saveButtonTitle, saveButtonTitle)
		XCTAssertEqual(viewModel.namePlaceholder, namePlaceholder)
		XCTAssertEqual(viewModel.httpProtocol, server.httpProtocol)
		XCTAssertEqual(viewModel.protocolPlaceholder, protocolPlaceholder)
		XCTAssertEqual(viewModel.ip, server.ip)
		XCTAssertEqual(viewModel.ipPlaceholder, ipPlaceholder)
		XCTAssertEqual(viewModel.port, server.port.description)
		XCTAssertEqual(viewModel.portPlaceholder, portPlaceholder)
		XCTAssertEqual(viewModel.username, server.username)
		XCTAssertEqual(viewModel.usernamePlaceholder, usernamePlaceholder)
		XCTAssertEqual(viewModel.password, server.password)
		XCTAssertEqual(viewModel.passwordPlaceholder, passwordPlaceholder)
		XCTAssertEqual(viewModel.serverId, serverId)
	}
	
}
