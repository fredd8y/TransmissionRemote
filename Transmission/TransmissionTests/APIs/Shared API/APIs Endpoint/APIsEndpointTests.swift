//
//  APIsEndpointTests.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 13/05/23.
//

import XCTest
import Transmission

final class APIsEndpointTests: XCTestCase {

	func test_apis_endpointURL() {
		let baseURL = URL(string: "http://base-url.com:9091")!
		
		let received = APIsEndpoint.post.url(baseURL: baseURL)
		
		XCTAssertEqual(received.scheme, "http", "scheme")
		XCTAssertEqual(received.host, "base-url.com", "host")
		XCTAssertEqual(received.port, 9091, "port")
		XCTAssertEqual(received.path, "/transmission/rpc", "path")
	}
	
}
