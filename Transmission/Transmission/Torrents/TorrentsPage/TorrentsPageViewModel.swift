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
		isLoading: Bool,
		error: String?,
		uploadSpeed: String,
		downloadSpeed: String,
		temporaryUploadSpeed: String,
		temporaryDownloadSpeed: String,
		temporarySpeedEnabled: Bool,
		torrents: [TorrentViewModel],
		freeDiskSpace: String,
		emptyMessage: String?,
		canAddTorrent: Bool,
		alertMessage: String?,
		alertMessageVisible: Bool = false
	) {
		self.title = title
		self.isLoading = isLoading
		self.error = error
		self.uploadSpeed = uploadSpeed
		self.downloadSpeed = downloadSpeed
		self.temporaryUploadSpeed = temporaryUploadSpeed
		self.temporaryDownloadSpeed = temporaryDownloadSpeed
		self.temporarySpeedEnabled = temporarySpeedEnabled
		self.torrents = torrents
		self.freeDiskSpace = freeDiskSpace
		self.emptyMessage = emptyMessage
		self.canAddTorrent = canAddTorrent
		self.alertMessage = alertMessage
		self.alertMessageVisible = alertMessageVisible
	}
	
	@Published public var title: String
	@Published public var isLoading: Bool
	@Published public var error: String?
	@Published public var canAddTorrent: Bool
	@Published public var uploadSpeed: String
	@Published public var downloadSpeed: String
	@Published public var temporaryUploadSpeed: String
	@Published public var temporaryDownloadSpeed: String
	@Published public var temporarySpeedEnabled: Bool
	@Published public var torrents: [TorrentViewModel]
	@Published public var freeDiskSpace: String
	@Published public var emptyMessage: String?
	@Published public var alertMessage: String?
	@Published public var alertMessageVisible: Bool
}
