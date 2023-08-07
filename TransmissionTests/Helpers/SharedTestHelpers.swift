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

func anySessionId() -> String {
	return "session id"
}

func anyString() -> String {
	return "any string"
}

func makeJSON(fromDictionary dictionary: [String: Any]) -> Data {
	return try! JSONSerialization.data(withJSONObject: dictionary)
}

extension HTTPURLResponse {
	convenience init(statusCode: Int, headerFields: [String: String]? = nil) {
		self.init(url: anyURL(), statusCode: statusCode, httpVersion: nil, headerFields: headerFields)!
	}
}
