//
//  TorrentsPageTests.swift
//  TransmissioniOSTests
//
//  Created by Federico Arvat on 19/07/23.
//

import XCTest
@testable import Transmission
@testable import TransmissioniOS

class TorrentsPageTests: XCTestCase {
	func test_emptyList() {
		let sut = makeSUT(torrents: emptyList())
		
		assert(snapshot: sut.snapshot(.iPhone13(style: .light)), named: "TORRENTS_PAGE_EMPTY_LIST_light")
		assert(snapshot: sut.snapshot(.iPhone13(style: .dark)), named: "TORRENTS_PAGE_EMPTY_LIST_dark")
	}
	
	func test_listWithErrorMessage() {
		let sut = makeSUT(torrents: emptyList(), error: "This is a\nmulti-line\nerror message")
		 
		assert(snapshot: sut.snapshot(.iPhone13(style: .light)), named: "TORRENTS_PAGE_LIST_WITH_ERROR_MESSAGE_light")
		assert(snapshot: sut.snapshot(.iPhone13(style: .dark)), named: "TORRENTS_PAGE_LIST_WITH_ERROR_MESSAGE_dark")
		assert(snapshot: sut.snapshot(.iPhone13(style: .light, contentSize: .extraExtraExtraLarge)), named: "TORRENTS_PAGE_LIST_WITH_ERROR_MESSAGE_light_extraExtraExtraLarge")
	}
	
	func test_listWithContent() {
		let sut = makeSUT(torrents: listWithContent())
		
		assert(snapshot: sut.snapshot(.iPhone13(style: .light)), named: "TORRENTS_PAGE_LIST_WITH_CONTENT_light")
		assert(snapshot: sut.snapshot(.iPhone13(style: .dark)), named: "TORRENTS_PAGE_LIST_WITH_CONTENT_dark")
		assert(snapshot: sut.snapshot(.iPhone13(style: .light, contentSize: .extraExtraExtraLarge)), named: "TORRENTS_PAGE_LIST_WITH_CONTENT_light_extraExtraExtraLarge")
	}
	
	func test_listWithItemError() {
		let sut = makeSUT(torrents: listWithItemError())
		
		assert(snapshot: sut.snapshot(.iPhone13(style: .light)), named: "TORRENTS_PAGE_LIST_WITH_ITEM_ERROR_light")
		assert(snapshot: sut.snapshot(.iPhone13(style: .dark)), named: "TORRENTS_PAGE_LIST_WITH_ITEM_ERROR_dark")
		assert(snapshot: sut.snapshot(.iPhone13(style: .light, contentSize: .extraExtraExtraLarge)), named: "TORRENTS_PAGE_LIST_WITH_ITEM_ERROR_light_extraExtraExtraLarge")
	}
	
	func test_emptyMessage() {
		let sut = makeSUT(torrents: emptyList(), emptyMessage: emptyMessage)
		
		assert(snapshot: sut.snapshot(.iPhone13(style: .light)), named: "TORRENTS_PAGE_EMPTY_MESSAGE_light")
		assert(snapshot: sut.snapshot(.iPhone13(style: .dark)), named: "TORRENTS_PAGE_EMPTY_MESSAGE_dark")
		assert(snapshot: sut.snapshot(.iPhone13(style: .light, contentSize: .extraExtraExtraLarge)), named: "TORRENTS_PAGE_EMPTY_MESSAGE_light_extraExtraExtraLarge")
	}
	
	func test_list_fromEmptyToFilled() {
		let sut = makeSUT(torrents: emptyList())
		
		assert(snapshot: sut.snapshot(.iPhone13(style: .light)), named: "TORRENTS_PAGE_EMPTY_LIST_light")
		assert(snapshot: sut.snapshot(.iPhone13(style: .dark)), named: "TORRENTS_PAGE_EMPTY_LIST_dark")
		
		sut.viewModel.torrents = listWithContent()
		
		assert(snapshot: sut.snapshot(.iPhone13(style: .light)), named: "TORRENTS_PAGE_LIST_WITH_CONTENT_light")
		assert(snapshot: sut.snapshot(.iPhone13(style: .dark)), named: "TORRENTS_PAGE_LIST_WITH_CONTENT_dark")
	}
	
	// MARK: - Helpers
	
	private func makeSUT(torrents: [TorrentViewModel], error: String? = nil, emptyMessage: String? = nil) -> TorrentsPage {
		TorrentsPage(viewModel: viewModel(withTorrents: torrents, andError: error, emptyMessage: emptyMessage))
	}
	
	private func viewModel(withTorrents torrents: [TorrentViewModel], andError error: String? = nil, emptyMessage: String? = nil) -> TorrentsViewModel {
		TorrentsViewModel(
			title: "Title",
			error: error,
			uploadSpeed: "5,5 MB/s",
			downloadSpeed: "5,5 MB/s",
			torrents: torrents,
			showAlert: false,
			emptyMessage: emptyMessage
		)
	}
	
	private func emptyList() -> [TorrentViewModel] {
		[]
	}
	
	private func listWithContent() -> [TorrentViewModel] {
		[
			TorrentViewModel(
				name: anyName,
				eta: anyEta,
				completionPercentage: anyPercentage,
				completionPercentageString: anyPercentageString,
				downloaded: anyDownloaded,
				downloadSpeed: anyDownloadSpeed
			),
			TorrentViewModel(
				name: anyName,
				eta: anyEta,
				completionPercentage: anyPercentage,
				completionPercentageString: anyPercentageString,
				downloaded: anyDownloaded,
				downloadSpeed: anyDownloadSpeed
			)
		]
	}
	
	private func listWithItemError() -> [TorrentViewModel] {
		[
			TorrentViewModel(
				name: anyName,
				error: anyError,
				eta: anyEta,
				completionPercentage: anyPercentage,
				completionPercentageString: anyPercentageString,
				downloaded: anyDownloaded,
				downloadSpeed: anyDownloadSpeed
			)
		]
	}
	
	// MARK: - Helpers
	
	private var anyName: String {
		"a name"
	}
	
	private var anyError: String {
		"Torrent error"
	}
	
	private var anyEta: String {
		"6y 7d 5h 34m 12s"
	}
	
	private var anyPercentage: Double {
		0.76
	}
	
	private var anyPercentageString: String {
		"76,75%"
	}
	
	private var anyDownloaded: String {
		"54MB of 5.6GB"
	}
	
	private var anyDownloadSpeed: String {
		"567Kb/s"
	}
	
	private var emptyMessage: String {
		"Test empty message"
	}
}