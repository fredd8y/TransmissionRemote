//
//  SessionField+FieldGroups.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 22/08/23.
//

import Foundation
import Transmission

extension SessionField {
	
	static var torrentsSettings: [String] {
		[
			downloadDir,
			seedRatioLimit,
			idleSeedingLimit,
			seedRatioLimited,
			startAddedTorrents,
			renamePartialFiles,
			idleSeedingLimitEnabled
		]
	}
	
}
