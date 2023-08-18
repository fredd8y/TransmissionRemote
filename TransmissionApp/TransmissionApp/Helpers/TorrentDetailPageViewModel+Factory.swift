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
