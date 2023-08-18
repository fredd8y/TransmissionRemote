//
//  TorrentDetailPageViewModel.swift
//  Transmission
//
//  Created by Federico Arvat on 17/08/23.
//

import Foundation

public class TorrentDetailPageViewModel: ObservableObject {
	
	public init(
		name: String,
		percentageCompleted: String,
		uploaded: String,
		ratio: String,
		downloaded: String,
		state: String,
		runningTime: String,
		remainingTime: String,
		lastActivity: String,
		error: String,
		size: String,
		location: String,
		hash: String,
		privacy: String
	) {
		self.name = name
		self.percentageCompleted = percentageCompleted
		self.uploaded = uploaded
		self.ratio = ratio
		self.downloaded = downloaded
		self.state = state
		self.runningTime = runningTime
		self.remainingTime = remainingTime
		self.lastActivity = lastActivity
		self.error = error
		self.size = size
		self.location = location
		self.hash = hash
		self.privacy = privacy
	}
	
	@Published public var name: String
	@Published public var percentageCompleted: String
	@Published public var uploaded: String
	@Published public var ratio: String
	@Published public var downloaded: String
	@Published public var state: String
	@Published public var runningTime: String
	@Published public var remainingTime: String
	@Published public var lastActivity: String
	@Published public var error: String
	@Published public var size: String
	@Published public var location: String
	@Published public var hash: String
	@Published public var privacy: String
	
}
