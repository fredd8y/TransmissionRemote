//
//  SessionGetAPIEndToEndTests.swift
//  TransmissionAPIEndToEndTests
//
//  Created by Federico Arvat on 15/07/23.
//

import XCTest
import Transmission

final class SessionGetAPIEndToEndTests: XCTestCase {

	func test_sessionGetAPI_return401StatusCodeForRequestWithoutCredentials() {
		let client = ephemeralClient()
		let exp = expectation(description: "Wait for load to complete")
		
		client.post(
			APIsEndpoint.post.url(baseURL: baseUrl!),
			body: SessionBodies.get.data(using: .utf8)!,
			additionalHeader: nil
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
	
	func test_sessionGetAPI_return401StatusCodeForRequestWithWrongCredentials() {
		let client = ephemeralClient()
		let exp = expectation(description: "Wait for load to complete")
				
		client.post(
			APIsEndpoint.post.url(baseURL: baseUrl!),
			body: SessionBodies.get.data(using: .utf8)!,
			additionalHeader: Self.wrongCredentialsHeader()
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
			additionalHeader: Self.correctCredentialsHeader()
		) { result in
			switch result {
			case let .failure(error):
				XCTFail("Expected success, got \(error) instead")
			case let .success((_, response)):
				XCTAssertEqual(response.statusCode, 409, "Expected 409, got \(response.statusCode) instead")
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
			additionalHeader: Self.correctCredentialsHeader()
		) { result in
			switch result {
			case let .failure(error):
				XCTFail("Expected success, got \(error) instead")
			case let .success((data, response)):
				do {
					_ = try SessionGetMapper.map(data, from: response)
					XCTFail("Expected missingSessionId exception")
				} catch {
					guard case let SessionGetMapper.Error.missingSessionId(sessionIdValue) = error else {
						XCTFail("Expected missingSessionId, got \(error) instead")
						return
					}
					guard let sessionId = sessionIdValue as? String else {
						XCTFail("Expected sessionId to be String, got \(String(describing: sessionIdValue.self)) instead")
						return
					}
					var additionalHeader = Self.correctCredentialsHeader()
					additionalHeader[SessionGetMapper.sessionIdKey] = sessionId
					client.post(
						APIsEndpoint.post.url(baseURL: baseUrl!),
						body: SessionBodies.get.data(using: .utf8)!,
						additionalHeader: additionalHeader
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
			}
		}
		wait(for: [exp], timeout: 5.0)
	}

	// MARK: - Helpers

	private func ephemeralClient(file: StaticString = #filePath, line: UInt = #line) -> HTTPClient {
		let client = URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
		trackForMemoryLeaks(client, file: file, line: line)
		return client
	}

	private static func wrongCredentialsHeader() -> [String: String] {
		[HeaderUtils.AUTHORIZATION_KEY: HeaderUtils.basicAuthCredentialsString(username: "wrong username", password: "wrong password")]
	}
	
	private static func correctCredentialsHeader() -> [String: String] {
		[HeaderUtils.AUTHORIZATION_KEY: HeaderUtils.basicAuthCredentialsString(username: username!, password: password!)]
	}
	
}
