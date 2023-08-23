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
		idleSeedingLimitEnabled: Bool,
		idleSeedingLimit: String,
		errorMessage: String?,
		isLoading: Bool
	) {
		self.downloadDir = downloadDir
		self.startAddedTorrents = startAddedTorrents
		self.renamePartialFiles = renamePartialFiles
		self.seedRatioLimited = seedRatioLimited
		self.seedRatioLimit = seedRatioLimit
		self.idleSeedingLimitEnabled = idleSeedingLimitEnabled
		self.idleSeedingLimit = idleSeedingLimit
		self.errorMessage = errorMessage
		self.isLoading = isLoading
	}
	
	@Published public var downloadDir: String
	@Published public var startAddedTorrents: Bool
	@Published public var renamePartialFiles: Bool
	@Published public var seedRatioLimited: Bool
	@Published public var seedRatioLimit: String
	@Published public var idleSeedingLimitEnabled: Bool
	@Published public var idleSeedingLimit: String
	@Published public var errorMessage: String?
	@Published public var isLoading: Bool
	@Published public var seedRatioLimitError: Bool = false
	@Published public var idleSeedingLimitError: Bool = false
}
