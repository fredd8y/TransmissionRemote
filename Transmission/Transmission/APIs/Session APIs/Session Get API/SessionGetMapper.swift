//
//  SessionGetMapper.swift
//  Transmission
//
//  Created by Federico Arvat on 13/05/23.
//

import Foundation

public final class SessionGetMapper {
	
	public enum Error: Swift.Error, Equatable {
		case invalidData
		case failed(explanation: String)
		
		public static func == (lhs: SessionGetMapper.Error, rhs: SessionGetMapper.Error) -> Bool {
			switch (lhs, rhs) {
			case (.invalidData, .invalidData):
				return true
            case (.failed, .failed):
                return true
			default:
				return false
			}
		}
	}
	
	public static func map(_ data: Data, from response: HTTPURLResponse) throws -> Session {
		guard response.isOK, let remoteSessionItem = try? JSONDecoder().decode(RemoteSession.self, from: data) else {
			throw Error.invalidData
		}
		if remoteSessionItem.result != SharedAPIsConstants.success {
			throw Error.failed(explanation: remoteSessionItem.result)
		}
		return remoteSessionItem.sessionItem
	}
	
	private struct RemoteSession: Decodable {
		
		let arguments: Arguments
		let result: String
		
		struct Arguments: Decodable {
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
			
			enum CodingKeys: String, CodingKey {
				case altSpeedDown = "alt-speed-down"
				case altSpeedEnabled = "alt-speed-enabled"
				case altSpeedTimeBegin = "alt-speed-time-begin"
				case altSpeedTimeDay = "alt-speed-time-day"
				case altSpeedTimeEnabled = "alt-speed-time-enabled"
				case altSpeedTimeEnd = "alt-speed-time-end"
				case altSpeedUp = "alt-speed-up"
				case blocklistEnabled = "blocklist-enabled"
				case blockListSize = "blocklist-size"
				case blocklistUrl = "blocklist-url"
				case cacheSizeMb = "cache-size-mb"
				case configDir = "config-dir"
				case dhtEnabled = "dht-enabled"
				case downloadDir = "download-dir"
				case downloadDirFreeSpace = "download-dir-free-space"
				case downloadQueueEnabled = "download-queue-enabled"
				case downloadQueueSize = "download-queue-size"
				case encryption
				case idleSeedingLimit = "idle-seeding-limit"
				case idleSeedingLimitEnabled = "idle-seeding-limit-enabled"
				case incompleteDir = "incomplete-dir"
				case incompleteDirEnabled = "incomplete-dir-enabled"
				case lpdEnabled = "lpd-enabled"
				case peerLimitGlobal = "peer-limit-global"
				case peerLimitPerTorrent = "peer-limit-per-torrent"
				case peerPort = "peer-port"
				case peerPortRandomOnStart = "peer-port-random-on-start"
				case pexEnabled = "pex-enabled"
				case portForwardingEnabled = "port-forwarding-enabled"
				case queueStalledEnabled = "queue-stalled-enabled"
				case queueStalledMinutes = "queue-stalled-minutes"
				case renamePartialFiles = "rename-partial-files"
				case rpcVersion = "rpc-version"
				case rpcVersionMinimum = "rpc-version-minimum"
				case scriptTorrentDoneEnabled = "script-torrent-done-enabled"
				case scriptTorrentDoneFilename = "script-torrent-done-filename"
				case seedQueueEnabled = "seed-queue-enabled"
				case seedQueueSize = "seed-queue-size"
				case seedRatioLimit
				case seedRatioLimited
				case sessionId = "session-id"
				case speedLimitDown = "speed-limit-down"
				case speedLimitDownEnabled = "speed-limit-down-enabled"
				case speedLimitUp = "speed-limit-up"
				case speedLimitUpEnabled = "speed-limit-up-enabled"
				case startAddedTorrents = "start-added-torrents"
				case trashOriginalTorrentFiles = "trash-original-torrent-files"
				case units
				case utpEnabled = "utp-enabled"
				case version
			}
			
			struct Units: Decodable {
				let memoryBytes: Int
				let memoryUnits: [String]
				let sizeBytes: Int
				let sizeUnits: [String]
				let speedBytes: Int
				let speedUnits: [String]
				
				enum CodingKeys: String, CodingKey {
					case memoryBytes = "memory-bytes"
					case memoryUnits = "memory-units"
					case sizeBytes = "size-bytes"
					case sizeUnits = "size-units"
					case speedBytes = "speed-bytes"
					case speedUnits = "speed-units"
				}
			}
		}
		
		var sessionItem: Session {
			return Session(
				altSpeedDown: arguments.altSpeedDown,
				altSpeedEnabled: arguments.altSpeedEnabled,
				altSpeedTimeBegin: arguments.altSpeedTimeBegin,
				altSpeedTimeDay: arguments.altSpeedTimeDay,
				altSpeedTimeEnabled: arguments.altSpeedTimeEnabled,
				altSpeedTimeEnd: arguments.altSpeedTimeEnd,
				altSpeedUp: arguments.altSpeedUp,
				blocklistEnabled: arguments.blocklistEnabled,
				blockListSize: arguments.blockListSize,
				blocklistUrl: arguments.blocklistUrl,
				cacheSizeMb: arguments.cacheSizeMb,
				configDir: arguments.configDir,
				dhtEnabled: arguments.dhtEnabled,
				downloadDir: arguments.downloadDir,
				downloadDirFreeSpace: arguments.downloadDirFreeSpace,
				downloadQueueEnabled: arguments.downloadQueueEnabled,
				downloadQueueSize: arguments.downloadQueueSize,
				encryption: arguments.encryption,
				idleSeedingLimit: arguments.idleSeedingLimit,
				idleSeedingLimitEnabled: arguments.idleSeedingLimitEnabled,
				incompleteDir: arguments.incompleteDir,
				incompleteDirEnabled: arguments.incompleteDirEnabled,
				lpdEnabled: arguments.lpdEnabled,
				peerLimitGlobal: arguments.peerLimitGlobal,
				peerLimitPerTorrent: arguments.peerLimitPerTorrent,
				peerPort: arguments.peerPort,
				peerPortRandomOnStart: arguments.peerPortRandomOnStart,
				pexEnabled: arguments.pexEnabled,
				portForwardingEnabled: arguments.portForwardingEnabled,
				queueStalledEnabled: arguments.queueStalledEnabled,
				queueStalledMinutes: arguments.queueStalledMinutes,
				renamePartialFiles: arguments.renamePartialFiles,
				rpcVersion: arguments.rpcVersion,
				rpcVersionMinimum: arguments.rpcVersionMinimum,
				scriptTorrentDoneEnabled: arguments.scriptTorrentDoneEnabled,
				scriptTorrentDoneFilename: arguments.scriptTorrentDoneFilename,
				seedQueueEnabled: arguments.seedQueueEnabled,
				seedQueueSize: arguments.seedQueueSize,
				seedRatioLimit: arguments.seedRatioLimit,
				seedRatioLimited: arguments.seedRatioLimited,
				sessionId: arguments.sessionId,
				speedLimitDown: arguments.speedLimitDown,
				speedLimitDownEnabled: arguments.speedLimitDownEnabled,
				speedLimitUp: arguments.speedLimitUp,
				speedLimitUpEnabled: arguments.speedLimitUpEnabled,
				startAddedTorrents: arguments.startAddedTorrents,
				trashOriginalTorrentFiles: arguments.trashOriginalTorrentFiles,
				units: Units(
					memoryBytes: arguments.units.memoryBytes,
					memoryUnits: arguments.units.memoryUnits,
					sizeBytes: arguments.units.sizeBytes,
					sizeUnits: arguments.units.sizeUnits,
					speedBytes: arguments.units.speedBytes,
					speedUnits: arguments.units.speedUnits
				),
				utpEnabled: arguments.utpEnabled,
				version: arguments.version
			)
		}
	}
	
}
