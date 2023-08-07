//
//  URLSessionHTTPClientRetrierDecoratorTests.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 17/07/23.
//

import XCTest
import Transmission

final class URLSessionHTTPClientRetrierDecoratorTests: XCTestCase {
	func test_getFromURL_returnMissingSessionIdOn409HTTPStatus() {
		let error = resultErrorFor((data: anyData(), response: HTTPURLResponse(statusCode: 409), error: nil)) as! URLSessionHTTPClientRetrierDecorator.Error
		
		guard case URLSessionHTTPClientRetrierDecorator.Error.missingSessionId = error else {
			XCTFail("Expected missingSessionId error, got \(error) instead")
			return
		}
	}
	
	// MARK: - Helpers
	
	private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> HTTPClient {
		let configuration = URLSessionConfiguration.ephemeral
		configuration.protocolClasses = [URLProtocolStub.self]
		let session = URLSession(configuration: configuration)
		
		let sut = URLSessionHTTPClientRetrierDecorator(decoratee: URLSessionHTTPClient(session: session))
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
	
	private func resultValuesFor(
		_ values: (data: Data?, response: URLResponse?, error: Error?),
		file: StaticString = #filePath,
		line: UInt = #line
	) -> (data: Data, response: HTTPURLResponse)? {
		let result = resultFor(values, file: file, line: line)
		
		switch result {
		case let .success(values):
			return values
		default:
			XCTFail("Expected success, got \(result) instead", file: file, line: line)
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
		// This taskHandler apply the input function to the URLSessionTask
		// returned by the post()
		taskHandler(sut.post(anyURL(), body: anyData(), username: anyUsername(), password: anyPassword(), sessionId: nil) { result in
			receivedResult = result
			exp.fulfill()
		})
		
		wait(for: [exp], timeout: 1.0)
		return receivedResult
	}
	
	private func anyHTTPURLResponse() -> HTTPURLResponse {
		return HTTPURLResponse(url: anyURL(), statusCode: 200, httpVersion: nil, headerFields: nil)!
	}
	
	private func nonHTTPURLResponse() -> URLResponse {
		return URLResponse(url: anyURL(), mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
	}
}
