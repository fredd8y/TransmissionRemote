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
	
	func test_cancelPostFromURLTask_cancelsURLRequest() {
		let exp = expectation(description: "Wait for request")
		URLProtocolStub.observeRequests { _ in exp.fulfill() }
		
		let receivedError = resultErrorFor(taskHandler: { $0.cancel() }) as NSError?
		wait(for: [exp], timeout: 1.0)
		
		XCTAssertEqual(receivedError?.code, URLError.cancelled.rawValue)
	}
	
	// MARK: - Helpers
	
	private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> HTTPClient {
		let configuration = URLSessionConfiguration.ephemeral
		configuration.protocolClasses = [URLProtocolStub.self]
		let session = URLSession(configuration: configuration)
		
		let sut = URLSessionHTTPClient(session: session)
		trackForMemoryLeaks(sut, file: file, line: line)
		return sut
	}
	
	private func resultErrorFor(
		_ values: (data: Data?, response: URLResponse?, error: Error?)? = nil,
		taskHandler: (URLSessionTask) -> Void = { _ in },
		file: StaticString = #filePath,
		line: UInt = #line
	) -> Error? {
		let result = resultFor(values, taskHandler: taskHandler, file: file, line: line)
		
		switch result {
		case let .failure(error):
			return error
		default:
			XCTFail("Expected failure, got \(result) instead", file: file, line: line)
			return nil
		}
	}
	
	private func resultFor(
		_ values: (data: Data?, response: URLResponse?, error: Error?)?,
		taskHandler: (URLSessionTask) -> Void = { _ in },
		file: StaticString = #filePath,
		line: UInt = #line
	) -> HTTPClient.Result {
		values.map { URLProtocolStub.stub(data: $0, response: $1, error: $2) }
		
		let sut = makeSUT(file: file, line: line)
		let exp = expectation(description: "Wait for completion")
		
		var receivedResult: HTTPClient.Result!
		taskHandler(sut.post(anyURL(), body: anyData()) { result in
			receivedResult = result
			exp.fulfill()
		})
		
		wait(for: [exp], timeout: 1.0)
		return receivedResult
	}
	
}
