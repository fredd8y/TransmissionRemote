//
//  TorrentsPageViewModel.swift
//  Transmission
//
//  Created by Federico Arvat on 20/07/23.
//

import Combine
import Foundation

public class TorrentsPageViewModel: ObservableObject {
	public init(
		title: String,
		error: String?,
		uploadSpeed: String,
		downloadSpeed: String,
		torrents: [TorrentViewModel],
		emptyMessage: String?,
		alertMessage: String?,
		alertMessageVisible: Bool = false
	) {
		self.title = title
		self.error = error
		self.uploadSpeed = uploadSpeed
		self.downloadSpeed = downloadSpeed
		self.torrents = torrents
		self.emptyMessage = emptyMessage
		self.alertMessage = alertMessage
		self.alertMessageVisible = alertMessageVisible
	}
	
	@Published public var title: String
	@Published public var error: String?
	@Published public var uploadSpeed: String
	@Published public var downloadSpeed: String
	@Published public var torrents: [TorrentViewModel]
	@Published public var emptyMessage: String?
	@Published public var alertMessage: String?
	@Published public var alertMessageVisible: Bool
}
