//
//  TorrentTrackersPageViewModel+Factory.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 21/08/23.
//

import Foundation
import Transmission

extension TorrentTrackersPageViewModel {
	static func empty() -> TorrentTrackersPageViewModel {
		TorrentTrackersPageViewModel(trackers: [])
	}
	static func error(_ errorMessage: String) -> TorrentTrackersPageViewModel {
		TorrentTrackersPageViewModel(trackers: [], errorMessage: errorMessage)
	}
}

