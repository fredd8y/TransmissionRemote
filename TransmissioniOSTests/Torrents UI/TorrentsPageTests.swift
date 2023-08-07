//
//  TorrentsPageTests.swift
//  TransmissioniOSTests
//
//  Created by Federico Arvat on 19/07/23.
//

import XCTest
import TransmissioniOS

class TorrentsPageTests: XCTestCase {
	func test_emptyList() {
		let sut = makeSUT(nil, torrents: emptyList())
		
		assert(snapshot: sut.snapshot(.iPhone13(style: .light)), named: "EMPTY_LIST_light")
		assert(snapshot: sut.snapshot(.iPhone13(style: .dark)), named: "EMPTY_LIST_dark")
	}
	
	func test_listWithErrorMessage() {
		let sut = makeSUT("This is a\nmulti-line\nerror message", torrents: emptyList())
		
		assert(snapshot: sut.snapshot(.iPhone13(style: .light)), named: "LIST_WITH_ERROR_MESSAGE_light")
		assert(snapshot: sut.snapshot(.iPhone13(style: .dark)), named: "LIST_WITH_ERROR_MESSAGE_dark")
		assert(snapshot: sut.snapshot(.iPhone13(style: .light, contentSize: .extraExtraExtraLarge)), named: "LIST_WITH_ERROR_MESSAGE_light_extraExtraExtraLarge")
	}
	
	func test_listWithContent() {
		let sut = makeSUT(nil, torrents: listWithContent())
		
		assert(snapshot: sut.snapshot(.iPhone13(style: .light)), named: "LIST_WITH_CONTENT_light")
		assert(snapshot: sut.snapshot(.iPhone13(style: .dark)), named: "LIST_WITH_CONTENT_dark")
		assert(snapshot: sut.snapshot(.iPhone13(style: .light, contentSize: .extraExtraExtraLarge)), named: "LIST_WITH_CONTENT_light_extraExtraExtraLarge")
	}
	
	// MARK: - Helpers
	
	private func makeSUT(_ error: String?, torrents: [TorrentsPage.TorrentViewModel]) -> TorrentsPage {
		TorrentsPage(title: "Title", torrents: torrents, error: error)
	}
	
	private func emptyList() -> [TorrentsPage.TorrentViewModel] {
		[]
	}
	
	private func listWithContent() -> [TorrentsPage.TorrentViewModel] {
		[
			TorrentsPage.TorrentViewModel(
				name: anyName,
				eta: anyEta,
				completionPercentage: anyPercentage,
				completionPercentageString: anyPercentageString,
				downloaded: anyDownloaded,
				downloadSpeed: anyDownloadSpeed
			),
			TorrentsPage.TorrentViewModel(
				name: anyName,
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
}
