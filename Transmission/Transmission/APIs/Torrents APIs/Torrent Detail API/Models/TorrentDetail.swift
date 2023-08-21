//
//  TorrentDetail.swift
//  Transmission
//
//  Created by Federico Arvat on 17/08/23.
//

import Foundation

public struct TorrentDetail: Equatable {
	
	public init(
		name: String,
		percentageAvailability: Double,
		uploaded: Int,
		ratio: Double,
		downloaded: Int,
		state: Status,
		startDate: Int,
		eta: Int,
		lastActivity: Int,
		error: String,
		size: Int,
		location: String,
		hash: String,
		isPrivate: Bool
	) {
		self.name = name
		self.percentageAvailability = percentageAvailability
		self.uploaded = uploaded
		self.ratio = ratio
		self.downloaded = downloaded
		self.state = state
		self.startDate = startDate
		self.eta = eta
		self.lastActivity = lastActivity
		self.error = error
		self.size = size
		self.location = location
		self.hash = hash
		self.isPrivate = isPrivate
	}
	
	let name: String
	let percentageAvailability: Double
	let uploaded: Int
	let ratio: Double
	let downloaded: Int
	let state: Status
	let startDate: Int
	let eta: Int
	let lastActivity: Int
	let error: String
	let size: Int
	let location: String
	let hash: String
	let isPrivate: Bool
	
}
