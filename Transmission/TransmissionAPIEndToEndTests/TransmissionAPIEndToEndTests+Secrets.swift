//
//  TransmissionAPIEndToEndTests+Secrets.swift
//  TransmissionAPIEndToEndTests
//
//  Created by Federico Arvat on 17/07/23.
//

import Foundation

var baseUrl: URL? {
	URL(string: Bundle(for: SessionGetAPIEndToEndTests.self).infoDictionary!["BASE_URL"] as! String)
}

var username: String? {
	Bundle(for: SessionGetAPIEndToEndTests.self).infoDictionary!["USERNAME"] as? String
}

var password: String? {
	Bundle(for: SessionGetAPIEndToEndTests.self).infoDictionary!["PASSWORD"] as? String
}
