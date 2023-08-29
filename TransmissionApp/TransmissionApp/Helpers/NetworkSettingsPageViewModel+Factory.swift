//
//  NetworkSettingsPageViewModel+Factory.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 29/08/23.
//

import Foundation
import Transmission

extension NetworkSettingsPageViewModel {
	static func loading() -> NetworkSettingsPageViewModel {
		NetworkSettingsPageViewModel(
			errorMessage: nil,
			isLoading: true,
			peerPort: "-",
			peerPortError: false,
			peerPortRandomOnStart: false,
			portForwardingEnabled: false,
			utpEnabled: false,
			portStatus: "-"
		)
	}
}
