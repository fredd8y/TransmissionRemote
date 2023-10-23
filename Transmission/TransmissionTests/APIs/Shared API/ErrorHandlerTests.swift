//
//  NetworkErrorHandlerTests.swift
//  TransmissionAppTests
//
//  Created by Federico Arvat on 20/10/23.
//

import XCTest
import Transmission

final class NetworkErrorHandlerTests: XCTestCase {

    func test_handleError_1001() {
        let error = NSError(domain: "timeout", code: -1001)
        
        let retrievedError = NetworkErrorHandler.handleError(error)
        
        XCTAssertTrue((retrievedError as? NetworkError) == NetworkError.serverTimeout, "Expected serverTimeoutError, got \(retrievedError) instead")
    }

    func test_handleError_1009() {
        let error = NSError(domain: "connection_unavailable", code: -1009)
        
        let retrievedError = NetworkErrorHandler.handleError(error)
        
        XCTAssertTrue((retrievedError as? NetworkError) == NetworkError.connectionUnavailable, "Expected authenticationFailed, got \(retrievedError) instead")
    }
    
    func test_handleError_default() {
        [-1000, 0, 1000].forEach {
            let error = NSError(domain: "invalid_data", code: $0)
            
            let retrievedError = NetworkErrorHandler.handleError(error)
            
            XCTAssertTrue((retrievedError as? NetworkError) == NetworkError.unknownError, "Expected invalidData, got \(retrievedError) instead")
        }
    }

}
