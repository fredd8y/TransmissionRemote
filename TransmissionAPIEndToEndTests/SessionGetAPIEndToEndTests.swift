//
//  SessionGetAPIEndToEndTests.swift
//  TransmissionAPIEndToEndTests
//
//  Created by Federico Arvat on 15/07/23.
//

import XCTest
import Transmission

final class SessionGetAPIEndToEndTests: XCTestCase {

	func test_sessionGetAPI_return401StatusCodeForRequestWithWrongCredentials() {
		let client = ephemeralClient()
		let exp = expectation(description: "Wait for load to complete")
				
		client.post(
			APIsEndpoint.post.url(baseURL: baseUrl!),
			body: SessionBodies.get.data(using: .utf8)!,
			username: "wrong username",
			password: "wrong password",
			sessionId: nil
		) { result in
			switch result {
			case let .failure(error):
				XCTFail("Expected success, got \(error) instead")
			case let .success((_, response)):
				XCTAssertEqual(response.statusCode, 401, "Expected 401, got \(response.statusCode) instead")
			}
			exp.fulfill()
		}
		wait(for: [exp], timeout: 5.0)
	}
	
	func test_sessionGetAPI_return409OnAuthenticatedRequestWithoutSessionId() {
		let client = ephemeralClient()
		let exp = expectation(description: "Wait for load to complete")

		client.post(
			APIsEndpoint.post.url(baseURL: baseUrl!),
			body: SessionBodies.get.data(using: .utf8)!,
			username: username!,
			password: password!,
			sessionId: nil
		) { result in
			switch result {
			case let .failure(error):
				guard case URLSessionHTTPClientRetrierDecorator.Error.missingSessionId = error else {
					XCTFail("Expected missingSessionId, got \(error) instead")
					return
				}
			case let .success((_, response)):
				XCTFail("Expected failure, got \(response) instead")
			}
			exp.fulfill()
		}
		wait(for: [exp], timeout: 5.0)
	}
	
	func test_sessionGetAPI_return200OnAuthenticatedRequestWithSessionId() {
		let client = ephemeralClient()
		let exp = expectation(description: "Wait for load to complete")
		
		client.post(
			APIsEndpoint.post.url(baseURL: baseUrl!),
			body: SessionBodies.get.data(using: .utf8)!,
			username: username!,
			password: password!,
			sessionId: nil
		) { result in
			switch result {
			case let .failure(error):
				switch error as! URLSessionHTTPClientRetrierDecorator.Error {
				case let .missingSessionId(sessionId):
					client.post(
						APIsEndpoint.post.url(baseURL: baseUrl!),
						body: SessionBodies.get.data(using: .utf8)!,
						username: username!,
						password: password!,
						sessionId: sessionId as? String
					) { result in
						switch result {
						case let .failure(error):
							XCTFail("Expected success, got \(error) instead")
						case let .success((_, response)):
							XCTAssertEqual(response.statusCode, 200, "Expected 200, got \(response.statusCode) instead")
						}
						exp.fulfill()
					}
				}
			case let .success((_, response)):
				XCTFail("Expected failure, got \(response) instead")
			}
		}
		wait(for: [exp], timeout: 5.0)
	}

	// MARK: - Helpers

	private func ephemeralClient(file: StaticString = #filePath, line: UInt = #line) -> HTTPClient {
		let client = URLSessionHTTPClientRetrierDecorator(decoratee: URLSessionHTTPClient(session: URLSession(configuration: .ephemeral)))
		trackForMemoryLeaks(client, file: file, line: line)
		return client
	}

}
