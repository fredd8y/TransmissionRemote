//
//  TorrentsSettings.swift
//  Transmission
//
//  Created by Federico Arvat on 22/08/23.
//

import Foundation

public struct TorrentsSettings: Equatable {
	public init(
		downloadDir: String,
		startAddedTorrents: Bool,
		renamePartialFiles: Bool,
		seedRatioLimited: Bool,
		seedRatioLimit: Int,
		idleSeedingLimitEnabled: Bool,
		idleSeedingLimit: Int
	) {
		self.downloadDir = downloadDir
		self.startAddedTorrents = startAddedTorrents
		self.renamePartialFiles = renamePartialFiles
		self.seedRatioLimited = seedRatioLimited
		self.seedRatioLimit = seedRatioLimit
		self.idleSeedingLimitEnabled = idleSeedingLimitEnabled
		self.idleSeedingLimit = idleSeedingLimit
	}
	
	public let downloadDir: String
	public let startAddedTorrents: Bool
	public let renamePartialFiles: Bool
	public let seedRatioLimited: Bool
	public let seedRatioLimit: Int
	public let idleSeedingLimitEnabled: Bool
	public let idleSeedingLimit: Int
}
