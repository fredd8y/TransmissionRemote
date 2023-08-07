//
//  ServerPageTests.swift
//  TransmissioniOSTests
//
//  Created by Federico Arvat on 29/07/23.
//

import XCTest
import Foundation
import Transmission
import TransmissioniOS

class ServerPageTests: XCTestCase {
	func test_emptyList() {
		let sut = makeSUT(servers: emptyList())
		
		assert(snapshot: sut.snapshot(.iPhone13(style: .light)), named: "SERVER_PAGE_EMPTY_LIST_light")
		assert(snapshot: sut.snapshot(.iPhone13(style: .dark)), named: "SERVER_PAGE_EMPTY_LIST_dark")
		assert(snapshot: sut.snapshot(.iPhone13(style: .light, contentSize: .extraExtraExtraLarge)), named: "SERVER_PAGE_EMPTY_LIST_light_extraExtraExtraLarge")
	}
	
	func test_listWithContent() {
		let sut = makeSUT(servers: listWithContent())
		
		assert(snapshot: sut.snapshot(.iPhone13(style: .light)), named: "SERVER_PAGE_LIST_WITH_CONTENT_light")
		assert(snapshot: sut.snapshot(.iPhone13(style: .dark)), named: "SERVER_PAGE_LIST_WITH_CONTENT_dark")
		assert(snapshot: sut.snapshot(.iPhone13(style: .light, contentSize: .extraExtraExtraLarge)), named: "SERVER_PAGE_LIST_WITH_CONTENT_light_extraExtraExtraLarge")
	}
	
	func test_listWithContentWithSelection() {
		let (servers, selectedServerId) = listWithContentWithSelection()
		
		let sut = makeSUT(servers: servers, currentSelectedServerId: selectedServerId)
		
		assert(snapshot: sut.snapshot(.iPhone13(style: .light)), named: "SERVER_PAGE_LIST_WITH_CONTENT_WITH_SELECTION_light")
		assert(snapshot: sut.snapshot(.iPhone13(style: .dark)), named: "SERVER_PAGE_LIST_WITH_CONTENT_WITH_SELECTION_dark")
		assert(snapshot: sut.snapshot(.iPhone13(style: .light, contentSize: .extraExtraExtraLarge)), named: "SERVER_PAGE_LIST_WITH_CONTENT_WITH_SELECTION_light_extraExtraExtraLarge")
	}
	
	// MARK: - Helpers
	
	private func makeSUT(servers: [ServerViewModel], currentSelectedServerId: UUID? = nil) -> ServerPage {
		ServerPage(viewModel: viewModel(servers: servers, currentSelectedServerId: currentSelectedServerId))
	}
	
	private func viewModel(servers: [ServerViewModel], currentSelectedServerId: UUID? = nil) -> ServerPageViewModel {
		ServerPageViewModel(
			title: ServerPagePresenter.title,
			servers: servers,
			editItemActionTitle: "Edit",
			deleteItemActionTitle: "Delete",
			currentSelectedServerId: currentSelectedServerId
		)
	}
	
	private func emptyList() -> [ServerViewModel] {
		[]
	}
	
	private func listWithContent() -> [ServerViewModel] {
		[
			ServerViewModel(
				title: "Raspberry",
				url: "http://192.168.1.1:9091",
				id: UUID()
			),
			ServerViewModel(
				title: "NAS",
				url: "http://192.168.1.2:9091",
				id: UUID()
			)
		]
	}
	
	private func listWithContentWithSelection() -> (servers: [ServerViewModel], selectedId: UUID) {
		let selectedId = UUID()
		return (servers: [
			ServerViewModel(
				title: "Raspberry",
				url: "http://192.168.1.1:9091",
				id: selectedId
			),
			ServerViewModel(
				title: "NAS",
				url: "http://192.168.1.2:9091",
				id: UUID()
			)
		], selectedId: selectedId)
	}
}
