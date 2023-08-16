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
	
	func test_emptyListLoading() {
		let sut = makeSUT(torrents: emptyList(), canAddTorrent: false, isLoading: true)
		
		assert(snapshot: sut.snapshot(.iPhone13(style: .light)), named: "TORRENTS_PAGE_EMPTY_LIST_LOADING_light")
		assert(snapshot: sut.snapshot(.iPhone13(style: .dark)), named: "TORRENTS_PAGE_EMPTY_LIST_LOADING_dark")
	}
	
	func test_listWithErrorMessage() {
		let sut = makeSUT(torrents: emptyList(), error: "This is a\nmulti-line\nerror message", canAddTorrent: false)
		 
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
	
	func test_listWithContentAndSpeedLimit() {
		let sut = makeSUT(torrents: listWithContent(), temporarySpeedEnabled: true)
		
		assert(snapshot: sut.snapshot(.iPhone13(style: .light)), named: "TORRENTS_PAGE_LIST_WITH_CONTENT_AND_SPEED_LIMIT_light")
		assert(snapshot: sut.snapshot(.iPhone13(style: .dark)), named: "TORRENTS_PAGE_LIST_WITH_CONTENT_AND_SPEED_LIMIT_dark")
		assert(snapshot: sut.snapshot(.iPhone13(style: .light, contentSize: .extraExtraExtraLarge)), named: "TORRENTS_PAGE_LIST_WITH_CONTENT_AND_SPEED_LIMIT_light_extraExtraExtraLarge")
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
	
	private func makeSUT(
		torrents: [TorrentViewModel],
		error: String? = nil,
		emptyMessage: String? = nil,
		canAddTorrent: Bool = true,
		isLoading: Bool = false,
		temporarySpeedEnabled: Bool = false
	) -> TorrentsPage {
		TorrentsPage(
			viewModel: viewModel(
				withTorrents: torrents,
				andError: error,
				emptyMessage: emptyMessage,
				canAddTorrent: canAddTorrent,
				isLoading: isLoading,
				temporarySpeedEnabled: temporarySpeedEnabled
			)
		)
	}
	
	private func viewModel(
		withTorrents torrents: [TorrentViewModel],
		andError error: String? = nil,
		emptyMessage: String? = nil,
		canAddTorrent: Bool = true,
		alertMessage: String? = nil,
		alertMessageVisible: Bool = false,
		isLoading: Bool = false,
		temporarySpeedEnabled: Bool = false
	) -> TorrentsPageViewModel {
		TorrentsPageViewModel(
			title: "Title",
			isLoading: isLoading,
			error: error,
			uploadSpeed: "5,5 MB/s",
			downloadSpeed: "5,5 MB/s",
			temporaryUploadSpeed: "5,5 MB/s",
			temporaryDownloadSpeed: "5,5 MB/s",
			temporarySpeedEnabled: temporarySpeedEnabled,
			torrents: torrents,
			freeDiskSpace: "256,0 GB",
			emptyMessage: emptyMessage,
			canAddTorrent: canAddTorrent,
			alertMessage: alertMessage,
			alertMessageVisible: alertMessageVisible
		)
	}
	
	private func emptyList() -> [TorrentViewModel] {
		[]
	}
	
	private func listWithContent() -> [TorrentViewModel] {
		[
			TorrentViewModel(
				id: 1,
				name: anyName,
				description: anyEta,
				completionPercentage: anyPercentage,
				completionPercentageString: anyPercentageString,
				downloaded: anyDownloaded,
				downloadSpeed: anyDownloadSpeed,
				status: .running
			),
			TorrentViewModel(
				id: 2,
				name: anyName,
				description: anyEta,
				completionPercentage: anyPercentage,
				completionPercentageString: anyPercentageString,
				downloaded: anyDownloaded,
				downloadSpeed: anyDownloadSpeed,
				status: .running
			)
		]
	}
	
	private func listWithItemError() -> [TorrentViewModel] {
		[
			TorrentViewModel(
				id: 1,
				name: anyName,
				error: anyError,
				description: anyEta,
				completionPercentage: anyPercentage,
				completionPercentageString: anyPercentageString,
				downloaded: anyDownloaded,
				downloadSpeed: anyDownloadSpeed,
				status: .stopped
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
