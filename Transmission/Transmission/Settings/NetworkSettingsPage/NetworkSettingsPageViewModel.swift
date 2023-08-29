//
//  NetworkSettingsPageViewModel.swift
//  Transmission
//
//  Created by Federico Arvat on 29/08/23.
//

import Foundation


public class NetworkSettingsPageViewModel: ObservableObject {
	public init(
		errorMessage: String?,
		isLoading: Bool,
		peerPort: String,
		peerPortError: Bool,
		peerPortRandomOnStart: Bool,
		portForwardingEnabled: Bool,
		utpEnabled: Bool,
		portStatus: String
	) {
		self.errorMessage = errorMessage
		self.isLoading = isLoading
		self.peerPort = peerPort
		self.peerPortError = peerPortError
		self.peerPortRandomOnStart = peerPortRandomOnStart
		self.portForwardingEnabled = portForwardingEnabled
		self.utpEnabled = utpEnabled
		self.portStatus = portStatus
	}
	
	@Published public var errorMessage: String?
	@Published public var isLoading: Bool
	@Published public var peerPort: String
	@Published public var peerPortError: Bool
	@Published public var peerPortRandomOnStart: Bool
	@Published public var portForwardingEnabled: Bool
	@Published public var utpEnabled: Bool
	@Published public var portStatus: String
}
