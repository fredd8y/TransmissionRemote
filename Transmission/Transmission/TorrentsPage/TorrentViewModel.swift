//
//  TorrentViewModel.swift
//  Transmission
//
//  Created by Federico Arvat on 18/07/23.
//

import Foundation

public struct TorrentViewModel: Identifiable, Equatable {
	public init(
		id: Int,
		name: String,
		error: String? = nil,
		eta: String,
		completionPercentage: Double,
		completionPercentageString: String,
		downloaded: String,
		downloadSpeed: String
	) {
		self.id = id
		self.name = name
		self.error = error
		self.eta = eta
		self.completionPercentage = completionPercentage
		self.completionPercentageString = completionPercentageString
		self.downloaded = downloaded
		self.downloadSpeed = downloadSpeed
	}
	
	public let id: Int
	public let name: String
	public let error: String?
	public let eta: String
	public let completionPercentage: Double
	public let completionPercentageString: String
	public let downloaded: String
	public let downloadSpeed: String
	
	public static func == (lhs: Self, rhs: Self) -> Bool {
		return lhs.name == rhs.name &&
		lhs.error == rhs.error &&
		lhs.eta == rhs.eta &&
		lhs.completionPercentage == rhs.completionPercentage &&
		lhs.completionPercentageString == rhs.completionPercentageString &&
		lhs.downloaded == rhs.downloaded &&
		lhs.downloadSpeed == rhs.downloadSpeed
	}
}
