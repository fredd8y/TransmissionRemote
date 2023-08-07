//
//  SharedServerTests.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 30/07/23.
//

import XCTest
import Transmission

class XCServerTestCase: XCTestCase {
	func server(_ id: UUID = UUID()) -> Server {
		Server(
			name: "a server",
			httpProtocol: .http,
			ip: "192.168.0.1",
			port: 9091,
			username: "a username",
			password: "a password",
			id: id
		)
	}
}
