//
//  NetworkSettings.swift
//  Transmission
//
//  Created by Federico Arvat on 29/08/23.
//

import Foundation

public struct NetworkSettings: Equatable {
	public init(
		peerPort: Int,
		peerPortRandomOnStart: Bool,
		portForwardingEnabled: Bool,
		utpEnabled: Bool
	) {
		self.peerPort = peerPort
		self.peerPortRandomOnStart = peerPortRandomOnStart
		self.portForwardingEnabled = portForwardingEnabled
		self.utpEnabled = utpEnabled
	}
	
	let peerPort: Int
	let peerPortRandomOnStart: Bool
	let portForwardingEnabled: Bool
	let utpEnabled: Bool
}
