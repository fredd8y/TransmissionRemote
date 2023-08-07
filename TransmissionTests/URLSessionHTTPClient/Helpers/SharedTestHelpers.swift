//
//  SharedTestHelpers.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 11/05/23.
//

import Foundation

func anyURL() -> URL {
	return URL(string: "http://any-url.com")!
}

func anyData() -> Data {
	return Data("any data".utf8)
}

func anyNSError() -> NSError {
	return NSError(domain: "any error", code: 0)
}
