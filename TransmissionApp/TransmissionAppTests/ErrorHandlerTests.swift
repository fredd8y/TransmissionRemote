//
//  ErrorHandlerTests.swift
//  TransmissionAppTests
//
//  Created by Federico Arvat on 20/10/23.
//

import XCTest
@testable import Transmission
@testable import TransmissionApp

final class ErrorHandlerTests: XCTestCase {

    func test_handleError_1001() {
        let error = NSError(domain: "timeout", code: -1001)
        
        let retrievedError = ErrorHandler.handleError(error)
        
        XCTAssertTrue((retrievedError as? SessionGetMapper.Error) == SessionGetMapper.Error.serverTimeout, "Expected serverTimeoutError, got \(retrievedError) instead")
    }

    func test_handleError_1009() {
        let error = NSError(domain: "connection_unavailable", code: -1009)
        
        let retrievedError = ErrorHandler.handleError(error)
        
        XCTAssertTrue((retrievedError as? SessionGetMapper.Error) == SessionGetMapper.Error.connectionUnavailable, "Expected authenticationFailed, got \(retrievedError) instead")
    }
    
    func test_handleError_default() {
        [-1000, 0, 1000].forEach {
            let error = NSError(domain: "invalid_data", code: $0)
            
            let retrievedError = ErrorHandler.handleError(error)
            
            XCTAssertTrue((retrievedError as? SessionGetMapper.Error) == SessionGetMapper.Error.invalidData, "Expected invalidData, got \(retrievedError) instead")
        }
    }

}
