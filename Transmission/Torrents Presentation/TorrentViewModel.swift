//
//  TorrentViewModel.swift
//  Transmission
//
//  Created by Federico Arvat on 18/07/23.
//

import Foundation

public struct TorrentViewModel {
	public let name: String
	public let error: String?
	public let eta: String
	public let completionPercentage: String
	public let downloadSpeed: String
	public let size: String
	public let alreadyDownloadedSize: String
}
