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
