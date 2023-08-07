//
//  APIEndToEndConfigurationsTests.swift
//  TransmissionAPIEndToEndTests
//
//  Created by Federico Arvat on 17/07/23.
//

import XCTest
import Transmission

final class APIEndToEndConfigurationsTests: XCTestCase {
	func test_configurations_isEndToEndTestConfigurationsFilePresent() {
		XCTAssertNotNil(
			Bundle(for: SessionGetAPIEndToEndTests.self).path(forResource: "EndToEndTestConfigurations", ofType: "xcconfig"),
			"Missing EndToEndTestConfigurations.xcconfig file"
		)
	}
	
	func test_configurations_isBaseUrlConfigurationPresent() {
		XCTAssertNotNil(baseUrl, "Missing BASE_URL property in EndToEndTestConfigurations.xcconfig file")
	}
	
	func test_configurations_isUsernameConfigurationPresent() {
		XCTAssertNotNil(username, "Missing USERNAME property in EndToEndTestConfigurations.xcconfig file")
	}
	
	func test_configurations_isPasswordConfigurationPresent() {
		XCTAssertNotNil(password, "Missing PASSWORD property in EndToEndTestConfigurations.xcconfig file")
	}
}
