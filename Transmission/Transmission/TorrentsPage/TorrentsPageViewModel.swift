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
		showAlert: Bool,
		emptyMessage: String?
	) {
		self.title = title
		self.error = error
		self.uploadSpeed = uploadSpeed
		self.downloadSpeed = downloadSpeed
		self.torrents = torrents
		self.showAlert = showAlert
		self.emptyMessage = emptyMessage
	}
	
	@Published public var title: String
	@Published public var error: String?
	@Published public var uploadSpeed: String
	@Published public var downloadSpeed: String
	@Published public var torrents: [TorrentViewModel]
	@Published public var showAlert: Bool
	@Published public var emptyMessage: String?
}
