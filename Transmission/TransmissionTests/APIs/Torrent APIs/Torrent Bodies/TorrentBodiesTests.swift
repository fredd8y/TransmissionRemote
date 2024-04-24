//
//  TorrentBodiesTests.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 15/05/23.
//

import XCTest
import Transmission

final class TorrentBodiesTests: XCTestCase {
	func assertEqual(
		_ arg0: Data,
		_ arg1: Data,
		file: StaticString = #filePath,
		line: UInt = #line
	) {
		XCTAssertEqual(
			arg0,
			arg1,
			"Expected \(String(data: arg0, encoding: .utf8)!) and \(String(data: arg1, encoding: .utf8)!) to be equal"
		)
	}
}

extension TorrentBodiesTests {
	
	func test_torrentGet_httpBodyWithEmptyFields() {
		let expectedBody = #"{"arguments":{"fields":[]},"method":"torrent-get"}"#.data(using: .utf8)!
		
		let httpBody = TorrentBodies.get(id: nil, fields: [])
		
		assertEqual(expectedBody, httpBody)
	}
	
	
	func test_torrentGet_httpBodyWithFields() {
		let expectedBody = #"{"arguments":{"fields":["field1","field2","field3"]},"method":"torrent-get"}"#.data(using: .utf8)!
		
		let httpBody = TorrentBodies.get(id: nil, fields: ["field1", "field2", "field3"])
		
		assertEqual(expectedBody, httpBody)
	}
	
	func test_torrentGet_httpBodyWithFieldsAndId() {
		let expectedBody = #"{"arguments":{"fields":["field1","field2","field3"],"ids":[1]},"method":"torrent-get"}"#.data(using: .utf8)!
		
		let httpBody = TorrentBodies.get(id: 1, fields: ["field1", "field2", "field3"])
		
		assertEqual(expectedBody, httpBody)
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
		
		let expectedBody = #"{"arguments":{"download-dir":"\#(downloadUrl)","metainfo":"\#(base64EncodedContent)","paused":false},"method":"torrent-add"}"#.data(using: .utf8)!
		
		let httpBody = try! TorrentBodies.add(startWhenAdded: true, downloadDir: anyDownloadDir(), torrentFilePath: fileUrl, filename: nil)
		
		assertEqual(expectedBody, httpBody)
	}
	
	func test_torrentAddLink_httpBody() {
		let downloadUrl = anyDownloadDir()
		
		let fileName = "a file name"
				
		let expectedBody = #"{"arguments":{"download-dir":"\#(downloadUrl)","filename":"\#(fileName)","paused":false},"method":"torrent-add"}"#.data(using: .utf8)!
		
		let httpBody = try! TorrentBodies.add(startWhenAdded: true, downloadDir: anyDownloadDir(), torrentFilePath: nil, filename: fileName)
		
		assertEqual(expectedBody, httpBody)
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
		let expectedBody = #"{"arguments":{"delete-local-data":true,"ids":[1]},"method":"torrent-remove"}"#.data(using: .utf8)!
		
		let httpBody = TorrentBodies.remove(id: 1, deleteLocalData: true)
		
		assertEqual(expectedBody, httpBody)
	}
	
	func test_torrentRemove_httpBodyPreservingLocalData() {
		let expectedBody = #"{"arguments":{"delete-local-data":false,"ids":[1]},"method":"torrent-remove"}"#.data(using: .utf8)!
		
		let httpBody = TorrentBodies.remove(id: 1, deleteLocalData: false)
		
		assertEqual(expectedBody, httpBody)
	}
}

extension TorrentBodiesTests {
	func test_torrentRemoveAll_httpBodyDeletingLocalData() {
		let expectedBody = #"{"arguments":{"delete-local-data":true},"method":"torrent-remove"}"#.data(using: .utf8)!
		
		let httpBody = TorrentBodies.removeAll(deleteLocalData: true)
		
		assertEqual(expectedBody, httpBody)
	}
	
	func test_torrentRemoveAll_httpBodyPreservingLocalData() {
		let expectedBody = #"{"arguments":{"delete-local-data":false},"method":"torrent-remove"}"#.data(using: .utf8)!
		
		let httpBody = TorrentBodies.removeAll(deleteLocalData: false)
		
		assertEqual(expectedBody, httpBody)
	}
}

extension TorrentBodiesTests {
	func test_torrentStop_httpBody() {
		let expectedBody = #"{"arguments":{"ids":[1]},"method":"torrent-stop"}"#.data(using: .utf8)!
		
		let httpBody = TorrentBodies.stop(id: 1)
		
		assertEqual(expectedBody, httpBody)
	}
}

extension TorrentBodiesTests {
	func test_torrentStopAll_httpBody() {
		let expectedBody = #"{"method":"torrent-stop"}"#.data(using: .utf8)!
		
		let httpBody = TorrentBodies.stopAll()
		
		assertEqual(expectedBody, httpBody)
	}
}

extension TorrentBodiesTests {
	func test_torrentStart_httpBody() {
		let expectedBody = #"{"arguments":{"ids":[1]},"method":"torrent-start"}"#.data(using: .utf8)!
		
		let httpBody = TorrentBodies.start(id: 1)
		
		assertEqual(expectedBody, httpBody)
	}
}

extension TorrentBodiesTests {
	func test_torrentStartAll_httpBody() {
		let expectedBody = #"{"method":"torrent-start"}"#.data(using: .utf8)!
		
		let httpBody = TorrentBodies.startAll()
		
		assertEqual(expectedBody, httpBody)
	}
}
