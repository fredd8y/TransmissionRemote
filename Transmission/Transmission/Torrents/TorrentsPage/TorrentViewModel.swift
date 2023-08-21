//
//  TorrentViewModel.swift
//  Transmission
//
//  Created by Federico Arvat on 18/07/23.
//

import Foundation

public struct TorrentViewModel: Identifiable, Equatable {
	
	public enum Status {
		case stopped
		case completed
		case running
	}
	
	public init(
		id: Int,
		name: String,
		error: String? = nil,
		description: String,
		completionPercentage: Double,
		completionPercentageString: String,
		downloaded: String,
		uploadSpeed: String,
		downloadSpeed: String,
		status: Status
	) {
		self.id = id
		self.name = name
		self.error = error
		self.description = description
		self.completionPercentage = completionPercentage
		self.completionPercentageString = completionPercentageString
		self.downloaded = downloaded
		self.uploadSpeed = uploadSpeed
		self.downloadSpeed = downloadSpeed
		self.status = status
	}
	
	public let id: Int
	public let name: String
	public let error: String?
	public let description: String
	public let completionPercentage: Double
	public let completionPercentageString: String
	public let downloaded: String
	public let uploadSpeed: String
	public let downloadSpeed: String
	public let status: Status
	
}
