//
//  TorrentDetailPageViewModel+Factory.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 17/08/23.
//

import Foundation
import Transmission

extension TorrentDetailPageViewModel {
	static func empty() -> TorrentDetailPageViewModel {
		TorrentDetailPageViewModel(
			name: "-",
			errorMessage: nil,
			percentageCompleted: "-",
			uploaded: "-",
			ratio: "-",
			downloaded: "-",
			state: "-",
			runningTime: "-",
			remainingTime: "-",
			lastActivity: "-",
			error: "-",
			size: "-",
			location: "-",
			hash: "-",
			privacy: "-"
		)
	}
	
	static func apiError(_ error: String) -> TorrentDetailPageViewModel {
		TorrentDetailPageViewModel(
			name: "-",
			errorMessage: error,
			percentageCompleted: "-",
			uploaded: "-",
			ratio: "-",
			downloaded: "-",
			state: "-",
			runningTime: "-",
			remainingTime: "-",
			lastActivity: "-",
			error: "-",
			size: "-",
			location: "-",
			hash: "-",
			privacy: "-"
		)
	}
}
