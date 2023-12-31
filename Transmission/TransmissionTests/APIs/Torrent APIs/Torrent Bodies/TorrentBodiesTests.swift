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
		
		let httpBody = TorrentBodies.get(id: nil, fields: [])
		
		XCTAssertEqual(expectedBody, httpBody)
	}
	
	
	func test_torrentGet_httpBodyWithFields() {
		let expectedBody = #"{"method":"torrent-get","arguments":{"fields":["field1","field2","field3"]}}"#.data(using: .utf8)
		
		let httpBody = TorrentBodies.get(id: nil, fields: ["field1", "field2", "field3"])
		
		XCTAssertEqual(expectedBody, httpBody)
	}
	
	func test_torrentGet_httpBodyWithFieldsAndId() {
		let expectedBody = #"{"method":"torrent-get","arguments":{"ids":[1],"fields":["field1","field2","field3"]}}"#.data(using: .utf8)
		
		let httpBody = TorrentBodies.get(id: 1, fields: ["field1", "field2", "field3"])
		
		XCTAssertEqual(expectedBody, httpBody)
	}
	
}

extension TorrentBodiesTests {
	
	func test_torrentAddFile_doesNotThrowOnCorrectInput() {
		let (fileUrl, _) = fileUrl()
		
		XCTAssertNoThrow(try TorrentBodies.add(startWhenAdded: true, downloadDir: anyDownloadDir(), torrentFilePath: fileUrl, filename: nil))
	}
	
	func test_torrentAddFile_throwsOnBadFileURL() {
		XCTAssertThrowsError(try TorrentBodies.add(startWhenAdded: true, downloadDir: anyDownloadDir(), torrentFilePath: "bad url", filename: nil))
	}
	
	func test_torrentAddLink_doesNotThrowOnCorrectInput() {
		XCTAssertNoThrow(try TorrentBodies.add(startWhenAdded: true, downloadDir: anyDownloadDir(), torrentFilePath: nil, filename: "a link"))
	}
	
	func test_torrentAdd_throwsWhenMissingSource() {
		XCTAssertThrowsError(try TorrentBodies.add(startWhenAdded: true, downloadDir: anyDownloadDir(), torrentFilePath: nil, filename: nil))
	}
	
	func test_torrentAddFile_httpBody() {
		let (fileUrl, base64EncodedContent) = fileUrl()
		
		let downloadUrl = anyDownloadDir()
		
		let expectedBody = #"{"method":"torrent-add","arguments":{"paused":false,"download-dir":"\#(downloadUrl)","metainfo":"\#(base64EncodedContent)"}}"#.data(using: .utf8)
		
		let httpBody = try! TorrentBodies.add(startWhenAdded: true, downloadDir: anyDownloadDir(), torrentFilePath: fileUrl, filename: nil)
		
		XCTAssertEqual(expectedBody, httpBody)
	}
	
	func test_torrentAddLink_httpBody() {
		let downloadUrl = anyDownloadDir()
		
		let fileName = "a file name"
				
		let expectedBody = #"{"method":"torrent-add","arguments":{"paused":false,"download-dir":"\#(downloadUrl)","filename":"\#(fileName)"}}"#.data(using: .utf8)
		
		let httpBody = try! TorrentBodies.add(startWhenAdded: true, downloadDir: anyDownloadDir(), torrentFilePath: nil, filename: fileName)
		
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

extension TorrentBodiesTests {
	func test_torrentRemove_httpBodyDeletingLocalData() {
		let expectedBody = #"{"method":"torrent-remove","arguments":{"ids":[1],"delete-local-data":true}}"#.data(using: .utf8)
		
		let httpBody = TorrentBodies.remove(id: 1, deleteLocalData: true)
		
		XCTAssertEqual(expectedBody, httpBody)
	}
	
	func test_torrentRemove_httpBodyPreservingLocalData() {
		let expectedBody = #"{"method":"torrent-remove","arguments":{"ids":[1],"delete-local-data":false}}"#.data(using: .utf8)
		
		let httpBody = TorrentBodies.remove(id: 1, deleteLocalData: false)
		
		XCTAssertEqual(expectedBody, httpBody)
	}
}

extension TorrentBodiesTests {
	func test_torrentRemoveAll_httpBodyDeletingLocalData() {
		let expectedBody = #"{"method":"torrent-remove","arguments":{"delete-local-data":true}}"#.data(using: .utf8)
		
		let httpBody = TorrentBodies.removeAll(deleteLocalData: true)
		
		XCTAssertEqual(expectedBody, httpBody)
	}
	
	func test_torrentRemoveAll_httpBodyPreservingLocalData() {
		let expectedBody = #"{"method":"torrent-remove","arguments":{"delete-local-data":false}}"#.data(using: .utf8)
		
		let httpBody = TorrentBodies.removeAll(deleteLocalData: false)
		
		XCTAssertEqual(expectedBody, httpBody)
	}
}

extension TorrentBodiesTests {
	func test_torrentStop_httpBody() {
		let expectedBody = #"{"method":"torrent-stop","arguments":{"ids":[1]}}"#.data(using: .utf8)
		
		let httpBody = TorrentBodies.stop(id: 1)
		
		XCTAssertEqual(expectedBody, httpBody)
	}
}

extension TorrentBodiesTests {
	func test_torrentStopAll_httpBody() {
		let expectedBody = #"{"method":"torrent-stop"}"#.data(using: .utf8)
		
		let httpBody = TorrentBodies.stopAll()
		
		XCTAssertEqual(expectedBody, httpBody)
	}
}

extension TorrentBodiesTests {
	func test_torrentStart_httpBody() {
		let expectedBody = #"{"method":"torrent-start","arguments":{"ids":[1]}}"#.data(using: .utf8)
		
		let httpBody = TorrentBodies.start(id: 1)
		
		XCTAssertEqual(expectedBody, httpBody)
	}
}

extension TorrentBodiesTests {
	func test_torrentStartAll_httpBody() {
		let expectedBody = #"{"method":"torrent-start"}"#.data(using: .utf8)
		
		let httpBody = TorrentBodies.startAll()
		
		XCTAssertEqual(expectedBody, httpBody)
	}
}
