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
	
	public let peerPort: Int
	public let peerPortRandomOnStart: Bool
	public let portForwardingEnabled: Bool
	public let utpEnabled: Bool
}
