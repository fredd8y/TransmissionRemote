//
//  TorrentPeersPageViewModel+Factory.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 21/08/23.
//

import Foundation
import Transmission

extension TorrentPeersPageViewModel {
	static func empty() -> TorrentPeersPageViewModel {
		TorrentPeersPageViewModel(peers: [], errorMessage: nil)
	}
	static func error(_ errorMessage: String) -> TorrentPeersPageViewModel {
		TorrentPeersPageViewModel(peers: [], errorMessage: errorMessage)
	}
}
