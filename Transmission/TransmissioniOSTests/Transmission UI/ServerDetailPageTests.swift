//
//  ServerDetailPageTests.swift
//  TransmissioniOS
//
//  Created by Federico Arvat on 30/07/23.
//

import XCTest
import SwiftUI
import Foundation
import Transmission
@testable import TransmissioniOS

class ServerDetailPageTests: XCTestCase {
	func test_empty() {
		let sut = makeSUT(viewModel: emptyViewModel())
				
		assert(snapshot: sut.snapshot(.iPhone13(style: .light)), named: "SERVER_DETAIL_PAGE_EMPTY_light")
		assert(snapshot: sut.snapshot(.iPhone13(style: .dark)), named: "SERVER_DETAIL_PAGE_EMPTY_dark")
		assert(snapshot: sut.snapshot(.iPhone13(style: .light, contentSize: .extraExtraExtraLarge)), named: "SERVER_DETAIL_PAGE_EMPTY_light_extraExtraExtraLarge")
	}
	
	func test_populated() {
		let sut = makeSUT(viewModel: populatedViewModel())
		
		assert(snapshot: sut.snapshot(.iPhone13(style: .light)), named: "SERVER_DETAIL_PAGE_light")
		assert(snapshot: sut.snapshot(.iPhone13(style: .dark)), named: "SERVER_DETAIL_PAGE_dark")
		assert(snapshot: sut.snapshot(.iPhone13(style: .light, contentSize: .extraExtraExtraLarge)), named: "SERVER_DETAIL_PAGE_light_extraExtraExtraLarge")
	}
	
	func test_populated_serverNameError() {
		let sut = makeSUT(viewModel: populatedViewModel(error: .name))
		
		assert(snapshot: sut.snapshot(.iPhone13(style: .light)), named: "SERVER_DETAIL_PAGE_SERVER_NAME_ERROR_light")
		assert(snapshot: sut.snapshot(.iPhone13(style: .dark)), named: "SERVER_DETAIL_PAGE_SERVER_NAME_ERROR_dark")
		assert(snapshot: sut.snapshot(.iPhone13(style: .light, contentSize: .extraExtraExtraLarge)), named: "SERVER_DETAIL_PAGE_SERVER_NAME_ERROR_light_extraExtraExtraLarge")
	}
	
	func test_populated_ipError() {
		let sut = makeSUT(viewModel: populatedViewModel(error: .ip))
		
		assert(snapshot: sut.snapshot(.iPhone13(style: .light)), named: "SERVER_DETAIL_PAGE_IP_ERROR_light")
		assert(snapshot: sut.snapshot(.iPhone13(style: .dark)), named: "SERVER_DETAIL_PAGE_IP_ERROR_dark")
		assert(snapshot: sut.snapshot(.iPhone13(style: .light, contentSize: .extraExtraExtraLarge)), named: "SERVER_DETAIL_PAGE_IP_ERROR_light_extraExtraExtraLarge")
	}
	
	func test_populated_portError() {
		let sut = makeSUT(viewModel: populatedViewModel(error: .port))
		
		assert(snapshot: sut.snapshot(.iPhone13(style: .light)), named: "SERVER_DETAIL_PAGE_PORT_ERROR_light")
		assert(snapshot: sut.snapshot(.iPhone13(style: .dark)), named: "SERVER_DETAIL_PAGE_PORT_ERROR_dark")
		assert(snapshot: sut.snapshot(.iPhone13(style: .light, contentSize: .extraExtraExtraLarge)), named: "SERVER_DETAIL_PAGE_PORT_ERROR_light_extraExtraExtraLarge")
	}
	
	func test_populated_usernameError() {
		let sut = makeSUT(viewModel: populatedViewModel(error: .username))
		
		assert(snapshot: sut.snapshot(.iPhone13(style: .light)), named: "SERVER_DETAIL_PAGE_USERNAME_ERROR_light")
		assert(snapshot: sut.snapshot(.iPhone13(style: .dark)), named: "SERVER_DETAIL_PAGE_USERNAME_ERROR_dark")
		assert(snapshot: sut.snapshot(.iPhone13(style: .light, contentSize: .extraExtraExtraLarge)), named: "SERVER_DETAIL_PAGE_USERNAME_ERROR_light_extraExtraExtraLarge")
	}
	
	func test_populated_passwordError() {
		let sut = makeSUT(viewModel: populatedViewModel(error: .password))
		
		assert(snapshot: sut.snapshot(.iPhone13(style: .light)), named: "SERVER_DETAIL_PAGE_PASSWORD_ERROR_light")
		assert(snapshot: sut.snapshot(.iPhone13(style: .dark)), named: "SERVER_DETAIL_PAGE_PASSWORD_ERROR_dark")
		assert(snapshot: sut.snapshot(.iPhone13(style: .light, contentSize: .extraExtraExtraLarge)), named: "SERVER_DETAIL_PAGE_PASSWORD_ERROR_light_extraExtraExtraLarge")
	}
	
	// MARK: - Helpers
	
	private func makeSUT(viewModel: ServerDetailPageViewModel) -> ServerDetailPage {
		ServerDetailPage(viewModel: viewModel)
	}
	
	private func emptyViewModel() -> ServerDetailPageViewModel {
		ServerDetailPageViewModel(
			title: ServerDetailPagePresenter.title,
			serverId: UUID()
		)
	}
	
	private func populatedViewModel(error: ServerDetailPageError? = nil) -> ServerDetailPageViewModel {
		ServerDetailPageViewModel(
			title: ServerDetailPagePresenter.title,
			name: "Name",
			httpProtocol: .http,
			ip: "192.168.1.1",
			port: "9091",
			username: "a username",
			password: "a password",
			error: error,
			serverId: UUID()
		)
	}
}
