//
//  TorrentBodiesTests.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 15/05/23.
//

import XCTest
import Transmission

final class TorrentBodiesTests: XCTestCase {}

extension TorrentBodiesTests {
	
	func test_torrentGet_httpBodyWithEmptyFields() {
		let expectedBody = #"{"method":"torrent-get","arguments":{"fields":[]}}"#.data(using: .utf8)
		
		let httpBody = TorrentBodies.get([])
		
		XCTAssertEqual(expectedBody, httpBody)
	}
	
	
	func test_torrentGet_httpBodyWithFields() {
		let expectedBody = #"{"method":"torrent-get","arguments":{"fields":["field1","field2","field3"]}}"#.data(using: .utf8)
		
		let httpBody = TorrentBodies.get(["field1", "field2", "field3"])
		
		XCTAssertEqual(expectedBody, httpBody)
	}
	
}

extension TorrentBodiesTests {
	
	func test_torrentAdd_doesNotThrowOnCorrectInput() {
		let (fileUrl, _) = fileUrl()
		
		XCTAssertNoThrow(try TorrentBodies.add(startWhenAdded: true, downloadDir: anyDownloadDir(), torrentFilePath: fileUrl))
	}
	
	func test_torrentAdd_throwsOnBadFileURL() {
		XCTAssertThrowsError(try TorrentBodies.add(startWhenAdded: true, downloadDir: anyDownloadDir(), torrentFilePath: "bad url"))
	}
	
	func test_torrentAdd_httpBody() {
		let (fileUrl, base64EncodedContent) = fileUrl()
		
		let downloadUrl = anyDownloadDir()
		
		let expectedBody = #"{"method":"torrent-add","arguments":{"paused":false,"download-dir":"\#(downloadUrl)","metainfo":"\#(base64EncodedContent)"}}"#.data(using: .utf8)
		
		let httpBody = try! TorrentBodies.add(startWhenAdded: true, downloadDir: anyDownloadDir(), torrentFilePath: fileUrl)
		
		XCTAssertEqual(expectedBody, httpBody)
	}
	
	// MARK: - Helpers
	
	private func fileUrl() -> (fileUrl: String, base64EncodedContent: String) {
		let temporaryFileUrl = FileManager.default.temporaryDirectory.appending(component: UUID().uuidString)
		
		let testContent = "test content".data(using: .utf8)!
		try! testContent.write(to: temporaryFileUrl)
		
		return (temporaryFileUrl.absoluteString, testContent.base64EncodedString())
	}
	
	private func anyDownloadDir() -> String {
		"a download dir"
	}
	
}
