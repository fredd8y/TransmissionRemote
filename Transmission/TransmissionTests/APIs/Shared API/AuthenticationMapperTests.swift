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
	
}
