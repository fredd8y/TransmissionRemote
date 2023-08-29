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
	
	static var speedSettings: [String] {
		[
			altSpeedUp,
			altSpeedDown,
			speedLimitUp,
			speedLimitDown,
			altSpeedTimeDay,
			altSpeedTimeEnd,
			altSpeedTimeBegin,
			altSpeedTimeEnabled,
			speedLimitUpEnabled,
			speedLimitDownEnabled
		]
	}
	
	static var peersSettings: [String] {
		[
			peerLimitGlobal,
			peerLimitPerTorrent,
			pexEnabled,
			dhtEnabled,
			lpdEnabled,
			blocklistEnabled,
			blocklistSize,
			blocklistUrl,
			encryption
		]
	}
	
	static var networkSettings: [String] {
		[
			peerPort,
			peerPortRandomOnStart,
			portForwardingEnabled,
			utpEnabled
		]
	}
	
}
