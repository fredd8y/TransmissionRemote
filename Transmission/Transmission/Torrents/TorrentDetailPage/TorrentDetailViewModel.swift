//
//  TorrentDetailViewModel.swift
//  Transmission
//
//  Created by Federico Arvat on 17/08/23.
//

import Foundation

public class TorrentDetailViewModel {
	
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
	
	let name: String
	let percentageCompleted: String
	let uploaded: String
	let ratio: String
	let downloaded: String
	let state: String
	let runningTime: String
	let remainingTime: String
	let lastActivity: String
	let error: String
	let size: String
	let location: String
	let hash: String
	let privacy: String
	
}
