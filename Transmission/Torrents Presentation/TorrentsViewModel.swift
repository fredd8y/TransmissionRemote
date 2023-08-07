//
//  TorrentsViewModel.swift
//  Transmission
//
//  Created by Federico Arvat on 20/07/23.
//

import Foundation

public struct TorrentsViewModel {
	public init(
		title: String,
		uploadSpeed: String,
		downloadSpeed: String,
		torrents: [TorrentViewModel]
	) {
		self.title = title
		self.uploadSpeed = uploadSpeed
		self.downloadSpeed = downloadSpeed
		self.torrents = torrents
	}
	
	public let title: String
	public let uploadSpeed: String
	public let downloadSpeed: String
	public let torrents: [TorrentViewModel]
}
