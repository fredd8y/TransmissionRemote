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
		
		makeSUT().post(
			url,
			body: data,
			username: anyUsername(),
			password: anyPassword(),
			sessionId: nil,
			completion: { _ in }
		)
		
		wait(for: [exp], timeout: 1.0)
	}
	
	func test_cancelPostFromURLTask_cancelsURLRequest() {
		let exp = expectation(description: "Wait for request")
		URLProtocolStub.observeRequests { _ in exp.fulfill() }
		
		let receivedError = resultErrorFor(taskHandler: { $0.cancel() }) as NSError?
		wait(for: [exp], timeout: 1.0)
		
		XCTAssertEqual(receivedError?.code, URLError.cancelled.rawValue)
	}
	
	func test_postAtURL_failsOnRequestError() {
		let requestError = anyNSError()
		
		let receivedError = resultErrorFor((data: nil, response: nil, error: requestError))
		
		XCTAssertNotNil(receivedError)
	}
	
	func test_postAtURL_failsOnAllInvalidRepresentationCases() {
		XCTAssertNotNil(resultErrorFor((data: nil, response: nil, error: nil)))
		XCTAssertNotNil(resultErrorFor((data: nil, response: nonHTTPURLResponse(), error: nil)))
		XCTAssertNotNil(resultErrorFor((data: anyData(), response: nil, error: nil)))
		XCTAssertNotNil(resultErrorFor((data: anyData(), response: nil, error: anyNSError())))
		XCTAssertNotNil(resultErrorFor((data: nil, response: nonHTTPURLResponse(), error: anyNSError())))
		XCTAssertNotNil(resultErrorFor((data: nil, response: anyHTTPURLResponse(), error: anyNSError())))
		XCTAssertNotNil(resultErrorFor((data: anyData(), response: nonHTTPURLResponse(), error: anyNSError())))
		XCTAssertNotNil(resultErrorFor((data: anyData(), response: anyHTTPURLResponse(), error: anyNSError())))
		XCTAssertNotNil(resultErrorFor((data: anyData(), response: nonHTTPURLResponse(), error: nil)))
	}
	
	func test_postAtURL_succeedsOnHTTPURLResponseWithData() {
		let data = anyData()
		let response = anyHTTPURLResponse()
		
		let receivedValues = resultValuesFor((data: data, response: response, error: nil))
		
		XCTAssertEqual(receivedValues?.data, data)
		XCTAssertEqual(receivedValues?.response.url, response.url)
		XCTAssertEqual(receivedValues?.response.statusCode, response.statusCode)
	}
	
	// This test is for 204 no content status code, the HTTPURLResponse will return
	// empty data (Data()) when the response has no-content
	func test_postAtURL_succeedsWithEmptyDataOnHTTPURLResponseWithNilData() {
		let response = anyHTTPURLResponse()
		
		let receivedValues = resultValuesFor((data: nil, response: response, error: nil))
		
		let emptyData = Data()
		XCTAssertEqual(receivedValues?.data, emptyData)
		XCTAssertEqual(receivedValues?.response.url, response.url)
		XCTAssertEqual(receivedValues?.response.statusCode, response.statusCode)
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
