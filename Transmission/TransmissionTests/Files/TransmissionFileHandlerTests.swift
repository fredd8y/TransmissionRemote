//
//  TransmissionFileHandlerTests.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 27/07/23.
//

import XCTest
import Transmission

final class TransmissionFileHandlerTests: XCTestCase {
	
	private struct Test: Codable, Equatable {
		let test: String
	}
	
	func test_getContent() {
		let url = getURL()
		
		do {
			let testData = #"{"test":"test_value"}"#.data(using: .utf8)!
			let givenTest = try JSONDecoder().decode(Test.self, from: testData)
			try testData.write(to: url)
			let expectedTest = try TransmissionFileHandler.getContent(url) as Test
			XCTAssertEqual(givenTest, expectedTest)
		} catch {
			XCTFail("Expected to read succesfully at url \(url) got failure instead")
		}
	}
	
	func test_setContent() {
		let url = getURL()
		
		do {
			let testData = #"{"test":"test_value"}"#.data(using: .utf8)!
			try TransmissionFileHandler.setContent(url, content: Test(test: "test_value"))
			let writtenData = try Data(contentsOf: url)
			XCTAssertEqual(writtenData, testData)
		} catch {
			XCTFail("Expected to write succesfully at url \(url) got failure instead")
		}
	}
	
	// MARK: - Helpers
	
	func getURL() -> URL {
		return FileManager.default.temporaryDirectory.appendingPathExtension(UUID().uuidString)
	}
	
}
