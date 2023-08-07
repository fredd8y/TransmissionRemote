//
//  SessionItem.swift
//  Transmission
//
//  Created by Federico Arvat on 14/05/23.
//

import Foundation

public struct SessionItem: Equatable {
	public init(
		altSpeedDown: Int,
		altSpeedEnabled: Bool,
		altSpeedTimeBegin: Int,
		altSpeedTimeDay: Int,
		altSpeedTimeEnabled: Bool,
		altSpeedTimeEnd: Int,
		altSpeedUp: Int,
		blocklistEnabled: Bool,
		blockListSize: Int,
		blocklistUrl: String,
		cacheSizeMb: Int,
		configDir: String,
		dhtEnabled: Bool,
		downloadDir: String,
		downloadDirFreeSpace: Int,
		downloadQueueEnabled: Bool,
		downloadQueueSize: Int,
		encryption: String,
		idleSeedingLimit: Int,
		idleSeedingLimitEnabled: Bool,
		incompleteDir: String,
		incompleteDirEnabled: Bool,
		lpdEnabled: Bool,
		peerLimitGlobal: Int,
		peerLimitPerTorrent: Int,
		peerPort: Int,
		peerPortRandomOnStart: Bool,
		pexEnabled: Bool,
		portForwardingEnabled: Bool,
		queueStalledEnabled: Bool,
		queueStalledMinutes: Int,
		renamePartialFiles: Bool,
		rpcVersion: Int,
		rpcVersionMinimum: Int,
		scriptTorrentDoneEnabled: Bool,
		scriptTorrentDoneFilename: String,
		seedQueueEnabled: Bool,
		seedQueueSize: Int,
		seedRatioLimit: Int,
		seedRatioLimited: Bool,
		sessionId: String,
		speedLimitDown: Int,
		speedLimitDownEnabled: Bool,
		speedLimitUp: Int,
		speedLimitUpEnabled: Bool,
		startAddedTorrents: Bool,
		trashOriginalTorrentFiles: Bool,
		units: Units,
		utpEnabled: Bool,
		version: String
	) {
		self.altSpeedDown = altSpeedDown
		self.altSpeedEnabled = altSpeedEnabled
		self.altSpeedTimeBegin = altSpeedTimeBegin
		self.altSpeedTimeDay = altSpeedTimeDay
		self.altSpeedTimeEnabled = altSpeedTimeEnabled
		self.altSpeedTimeEnd = altSpeedTimeEnd
		self.altSpeedUp = altSpeedUp
		self.blocklistEnabled = blocklistEnabled
		self.blockListSize = blockListSize
		self.blocklistUrl = blocklistUrl
		self.cacheSizeMb = cacheSizeMb
		self.configDir = configDir
		self.dhtEnabled = dhtEnabled
		self.downloadDir = downloadDir
		self.downloadDirFreeSpace = downloadDirFreeSpace
		self.downloadQueueEnabled = downloadQueueEnabled
		self.downloadQueueSize = downloadQueueSize
		self.encryption = encryption
		self.idleSeedingLimit = idleSeedingLimit
		self.idleSeedingLimitEnabled = idleSeedingLimitEnabled
		self.incompleteDir = incompleteDir
		self.incompleteDirEnabled = incompleteDirEnabled
		self.lpdEnabled = lpdEnabled
		self.peerLimitGlobal = peerLimitGlobal
		self.peerLimitPerTorrent = peerLimitPerTorrent
		self.peerPort = peerPort
		self.peerPortRandomOnStart = peerPortRandomOnStart
		self.pexEnabled = pexEnabled
		self.portForwardingEnabled = portForwardingEnabled
		self.queueStalledEnabled = queueStalledEnabled
		self.queueStalledMinutes = queueStalledMinutes
		self.renamePartialFiles = renamePartialFiles
		self.rpcVersion = rpcVersion
		self.rpcVersionMinimum = rpcVersionMinimum
		self.scriptTorrentDoneEnabled = scriptTorrentDoneEnabled
		self.scriptTorrentDoneFilename = scriptTorrentDoneFilename
		self.seedQueueEnabled = seedQueueEnabled
		self.seedQueueSize = seedQueueSize
		self.seedRatioLimit = seedRatioLimit
		self.seedRatioLimited = seedRatioLimited
		self.sessionId = sessionId
		self.speedLimitDown = speedLimitDown
		self.speedLimitDownEnabled = speedLimitDownEnabled
		self.speedLimitUp = speedLimitUp
		self.speedLimitUpEnabled = speedLimitUpEnabled
		self.startAddedTorrents = startAddedTorrents
		self.trashOriginalTorrentFiles = trashOriginalTorrentFiles
		self.units = units
		self.utpEnabled = utpEnabled
		self.version = version
	}

	let altSpeedDown: Int
	let altSpeedEnabled: Bool
	let altSpeedTimeBegin: Int
	let altSpeedTimeDay: Int
	let altSpeedTimeEnabled: Bool
	let altSpeedTimeEnd: Int
	let altSpeedUp: Int
	let blocklistEnabled: Bool
	let blockListSize: Int
	let blocklistUrl: String
	let cacheSizeMb: Int
	let configDir: String
	let dhtEnabled: Bool
	let downloadDir: String
	let downloadDirFreeSpace: Int
	let downloadQueueEnabled: Bool
	let downloadQueueSize: Int
	let encryption: String
	let idleSeedingLimit: Int
	let idleSeedingLimitEnabled: Bool
	let incompleteDir: String
	let incompleteDirEnabled: Bool
	let lpdEnabled: Bool
	let peerLimitGlobal: Int
	let peerLimitPerTorrent: Int
	let peerPort: Int
	let peerPortRandomOnStart: Bool
	let pexEnabled: Bool
	let portForwardingEnabled: Bool
	let queueStalledEnabled: Bool
	let queueStalledMinutes: Int
	let renamePartialFiles: Bool
	let rpcVersion: Int
	let rpcVersionMinimum: Int
	let scriptTorrentDoneEnabled: Bool
	let scriptTorrentDoneFilename: String
	let seedQueueEnabled: Bool
	let seedQueueSize: Int
	let seedRatioLimit: Int
	let seedRatioLimited: Bool
	let sessionId: String
	let speedLimitDown: Int
	let speedLimitDownEnabled: Bool
	let speedLimitUp: Int
	let speedLimitUpEnabled: Bool
	let startAddedTorrents: Bool
	let trashOriginalTorrentFiles: Bool
	let units: Units
	let utpEnabled: Bool
	let version: String
}

public struct Units: Equatable {
	public init(
		memoryBytes: Int,
		memoryUnits: [String],
		sizeBytes: Int,
		sizeUnits: [String],
		speedBytes: Int,
		speedUnits: [String]
	) {
		self.memoryBytes = memoryBytes
		self.memoryUnits = memoryUnits
		self.sizeBytes = sizeBytes
		self.sizeUnits = sizeUnits
		self.speedBytes = speedBytes
		self.speedUnits = speedUnits
	}
	
	let memoryBytes: Int
	let memoryUnits: [String]
	let sizeBytes: Int
	let sizeUnits: [String]
	let speedBytes: Int
	let speedUnits: [String]
}
