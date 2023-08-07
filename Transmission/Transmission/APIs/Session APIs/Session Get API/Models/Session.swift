//
//  Session.swift
//  Transmission
//
//  Created by Federico Arvat on 14/05/23.
//

import Foundation

public struct Session: Equatable {
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

	public let altSpeedDown: Int
	public let altSpeedEnabled: Bool
	public let altSpeedTimeBegin: Int
	public let altSpeedTimeDay: Int
	public let altSpeedTimeEnabled: Bool
	public let altSpeedTimeEnd: Int
	public let altSpeedUp: Int
	public let blocklistEnabled: Bool
	public let blockListSize: Int
	public let blocklistUrl: String
	public let cacheSizeMb: Int
	public let configDir: String
	public let dhtEnabled: Bool
	public let downloadDir: String
	public let downloadDirFreeSpace: Int
	public let downloadQueueEnabled: Bool
	public let downloadQueueSize: Int
	public let encryption: String
	public let idleSeedingLimit: Int
	public let idleSeedingLimitEnabled: Bool
	public let incompleteDir: String
	public let incompleteDirEnabled: Bool
	public let lpdEnabled: Bool
	public let peerLimitGlobal: Int
	public let peerLimitPerTorrent: Int
	public let peerPort: Int
	public let peerPortRandomOnStart: Bool
	public let pexEnabled: Bool
	public let portForwardingEnabled: Bool
	public let queueStalledEnabled: Bool
	public let queueStalledMinutes: Int
	public let renamePartialFiles: Bool
	public let rpcVersion: Int
	public let rpcVersionMinimum: Int
	public let scriptTorrentDoneEnabled: Bool
	public let scriptTorrentDoneFilename: String
	public let seedQueueEnabled: Bool
	public let seedQueueSize: Int
	public let seedRatioLimit: Int
	public let seedRatioLimited: Bool
	public let sessionId: String
	public let speedLimitDown: Int
	public let speedLimitDownEnabled: Bool
	public let speedLimitUp: Int
	public let speedLimitUpEnabled: Bool
	public let startAddedTorrents: Bool
	public let trashOriginalTorrentFiles: Bool
	public let units: Units
	public let utpEnabled: Bool
	public let version: String
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
