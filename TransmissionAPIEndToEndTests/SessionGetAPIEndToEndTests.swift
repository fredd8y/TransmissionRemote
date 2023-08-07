//
//  SessionGetAPIEndToEndTests.swift
//  TransmissionAPIEndToEndTests
//
//  Created by Federico Arvat on 15/07/23.
//

import XCTest
import Transmission

final class SessionGetAPIEndToEndTests: XCTestCase {
//
//	func test_sessionGetAPI_isCorrectlyAuthenticated() {
//		let client = ephemeralClient()
//		let exp = expectation(description: "Wait for load to complete")
//		
//		let baseURL = URL(string: "http://192.168.178.39:9091")!
//		
//		var receivedResult: Result<Session, Error>?
//		client.post(APIsEndpoint.post.url(baseURL: baseURL), body: SessionBodies.get.data(using: .utf8)!) { result in
//			receivedResult = result.flatMap { (data, response) in
//				do {
//					return .success(try SessionGetMapper.map(data, from: response))
//				} catch {
//					return .failure(error)
//				}
//			}
//			exp.fulfill()
//		}
//		wait(for: [exp], timeout: 5.0)
//		switch receivedResult {
//		case let .failure(error):
//			XCTFail("Expected no error, got \(error) instead")
//		default:
//			break
//		}
//	}
//	
//    func test_sessionGetAPI_decodeCorrectlyOn200HTTPResponse() {
//		let client = ephemeralClient()
//		let exp = expectation(description: "Wait for load to complete")
//		
//		let baseURL = URL(string: "http://192.168.178.39:9091")!
//		
//		var receivedResult: Result<Session, Error>?
//		client.post(APIsEndpoint.post.url(baseURL: baseURL), body: SessionBodies.get.data(using: .utf8)!) { result in
//			receivedResult = result.flatMap { (data, response) in
//				do {
//					return .success(try SessionGetMapper.map(data, from: response))
//				} catch {
//					return .failure(error)
//				}
//			}
//			exp.fulfill()
//		}
//		wait(for: [exp], timeout: 5.0)
//		switch receivedResult {
//		case let .failure(error):
//			XCTFail("Expected no error, got \(error) instead")
//		default:
//			break
//		}
//	}
//	
//	// MARK: - Helpers
//	
//	private func ephemeralClient(file: StaticString = #filePath, line: UInt = #line) -> HTTPClient {
//		let client = URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
//		trackForMemoryLeaks(client, file: file, line: line)
//		return client
//	}

}
