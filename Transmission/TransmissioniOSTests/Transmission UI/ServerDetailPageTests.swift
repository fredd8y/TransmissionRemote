//
//  ServerDetailPageTests.swift
//  TransmissioniOS
//
//  Created by Federico Arvat on 30/07/23.
//

import XCTest
import Foundation
import Transmission
import TransmissioniOS

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
	
	// MARK: - Helpers
	
	private func makeSUT(viewModel: ServerDetailPageViewModel) -> ServerDetailPage {
		ServerDetailPage(viewModel: viewModel)
	}
	
	private func emptyViewModel() -> ServerDetailPageViewModel {
		ServerDetailPageViewModel(
			serverSectionHeader: ServerDetailPagePresenter.serverSectionHeader,
			authenticationSectionHeader: ServerDetailPagePresenter.authenticationSectionHeader,
			title: ServerDetailPagePresenter.title,
			saveButtonTitle: ServerDetailPagePresenter.saveButtonTitle,
			namePlaceholder: ServerDetailPagePresenter.namePlaceholder,
			protocolPlaceholder: ServerDetailPagePresenter.protocolPlaceholder,
			ipPlaceholder: ServerDetailPagePresenter.ipPlaceholder,
			portPlaceholder: ServerDetailPagePresenter.portPlaceholder,
			usernamePlaceholder: ServerDetailPagePresenter.usernamePlaceholder,
			passwordPlaceholder: ServerDetailPagePresenter.passwordPlaceholder
		)
	}
	
	private func populatedViewModel() -> ServerDetailPageViewModel {
		ServerDetailPageViewModel(
			serverSectionHeader: ServerDetailPagePresenter.serverSectionHeader,
			authenticationSectionHeader: ServerDetailPagePresenter.authenticationSectionHeader,
			title: ServerDetailPagePresenter.title,
			saveButtonTitle: ServerDetailPagePresenter.saveButtonTitle,
			name: "Name",
			namePlaceholder: ServerDetailPagePresenter.namePlaceholder,
			httpProtocol: .http,
			protocolPlaceholder: ServerDetailPagePresenter.protocolPlaceholder,
			ip: "192.168.1.1",
			ipPlaceholder: ServerDetailPagePresenter.ipPlaceholder,
			port: "9091",
			portPlaceholder: ServerDetailPagePresenter.portPlaceholder,
			username: "a username",
			usernamePlaceholder: ServerDetailPagePresenter.usernamePlaceholder,
			password: "a password",
			passwordPlaceholder: ServerDetailPagePresenter.passwordPlaceholder
		)
	}
}
