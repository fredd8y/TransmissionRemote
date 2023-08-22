//
//  TorrentsSettingsPageViewModel.swift
//  Transmission
//
//  Created by Federico Arvat on 22/08/23.
//

import SwiftUI

public class TorrentsSettingsPageViewModel: ObservableObject {
	public init(
		downloadDir: String,
		startAddedTorrents: Bool,
		renamePartialFiles: Bool,
		seedRatioLimited: Bool,
		seedRatioLimit: String,
		idleSeedingLimitedEnabled: Bool,
		idleSeedingLimit: String
	) {
		self.downloadDir = downloadDir
		self.startAddedTorrents = startAddedTorrents
		self.renamePartialFiles = renamePartialFiles
		self.seedRatioLimited = seedRatioLimited
		self.seedRatioLimit = seedRatioLimit
		self.idleSeedingLimitedEnabled = idleSeedingLimitedEnabled
		self.idleSeedingLimit = idleSeedingLimit
	}
	
	@Published public var downloadDir: String
	@Published public var startAddedTorrents: Bool
	@Published public var renamePartialFiles: Bool
	@Published public var seedRatioLimited: Bool
	@Published public var seedRatioLimit: String
	@Published public var idleSeedingLimitedEnabled: Bool
	@Published public var idleSeedingLimit: String
}
