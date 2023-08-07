//
//  URLSessionHTTPClientTests.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 11/05/23.
//

import XCTest
import Transmission

final class URLSessionHTTPClientTests: XCTestCase {

	override func tearDown() {
		super.tearDown()
		
		URLProtocolStub.removeStub()
	}
	
	func test_getFromURL_performPOSTRequestWithURL() {
		let url = anyURL()
		let data = Data("any data".utf8)
		let exp = expectation(description: "Wait for request")
		
		URLProtocolStub.observeRequests { request in
			XCTAssertEqual(request.url, url)
			XCTAssertEqual(request.bodyStreamData, data)
			XCTAssertEqual(request.httpMethod, "POST")
			exp.fulfill()
		}
		
		makeSUT().post(url, body: data, completion: { _ in })
		
		wait(for: [exp], timeout: 1.0)
	}
	
	private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> HTTPClient {
		let configuration = URLSessionConfiguration.ephemeral
		configuration.protocolClasses = [URLProtocolStub.self]
		let session = URLSession(configuration: configuration)
		
		let sut = URLSessionHTTPClient(session: session)
		trackForMemoryLeaks(sut, file: file, line: line)
		return sut
	}

}
