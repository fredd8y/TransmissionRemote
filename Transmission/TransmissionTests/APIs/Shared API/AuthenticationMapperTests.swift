//
//  AuthenticationMapperTests.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 23/10/23.
//

import XCTest
import Transmission

class AuthenticationMapperTests: XCTestCase {
	
	func test_map_throwsAuthenticationErrorOn401HTTPStatus() throws {
		let json = makeJSON(fromDictionary: [:])
		
		do {
			_ = try AuthenticationMapper.map(json, from: HTTPURLResponse(statusCode: 401))
		} catch {
			XCTAssertEqual(
				(error as! AuthenticationError),
				AuthenticationError.authenticationFailed,
				"Expected authenticationFailed error, got \(error) instead"
			)
		}
	}
	
	func test_map_throwsSessionIdErrorOn409HTTPResponse() throws {
		let json = makeJSON(fromDictionary: [:])
		let sessionIdValue = anyString()
		do {
			_ = try AuthenticationMapper.map(
				json,
				from: HTTPURLResponse(statusCode: 409, headerFields: [AuthenticationConstants.sessionIdKey: sessionIdValue])
			)
		} catch {
			guard let _error = error as? AuthenticationError else {
				XCTFail("Expected SessionGetMapper.Error value, got \(error.self) instead")
				return
			}
			if case let AuthenticationError.missingSessionId(sessionId) = _error {
				if let sessionId {
					XCTAssertEqual(sessionIdValue, sessionId)
				} else {
					XCTFail("Expected String sessionIdValue value, got \(String(describing: sessionId)) instead")
				}
			} else {
				XCTFail("Expected missingSessionId value, got \(error.self) instead")
			}
		}
	}
	
}
