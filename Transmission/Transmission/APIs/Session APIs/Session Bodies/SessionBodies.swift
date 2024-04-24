//
//  SessionBodies.swift
//  Transmission
//
//  Created by Federico Arvat on 13/05/23.
//

import Foundation

public class SessionBodies {
	public static let get = #"{"method": "session-get"}"#
	public static let stats = #"{"method": "session-stats"}"#
	static var encoder: JSONEncoder {
		let encoder = JSONEncoder()
		encoder.outputFormatting = .sortedKeys
		return encoder
	}
}

extension SessionBodies {
	
	private struct SetListeningPortBody: Encodable {
		init(_ peerPort: Int) {
			arguments = Arguments(peerPort: peerPort)
		}
		
		let method: String = "session-set"
		let arguments: Arguments
		
		struct Arguments: Encodable {
			let peerPort: Int
			
			enum CodingKeys: String, CodingKey {
				case peerPort = "peer-port"
			}
		}
	}
	
	public static func setListeningPort(port: Int) -> Data {
		try! encoder.encode(SetListeningPortBody(port))
	}
	
}

extension SessionBodies {
	
	private struct SetUtpEnabledBody: Encodable {
		init(_ utpEnabled: Bool) {
			arguments = Arguments(utpEnabled: utpEnabled)
		}
		
		let method: String = "session-set"
		let arguments: Arguments
		
		struct Arguments: Encodable {
			let utpEnabled: Bool
			
			enum CodingKeys: String, CodingKey {
				case utpEnabled = "utp-enabled"
			}
		}
	}
	
	public static func setUtpEnabled(enabled: Bool) -> Data {
		try! encoder.encode(SetUtpEnabledBody(enabled))
	}
	
}

extension SessionBodies {
	
	private struct SetPortRandomOnStartBody: Encodable {
		init(_ peerPortRandomOnStart: Bool) {
			arguments = Arguments(peerPortRandomOnStart: peerPortRandomOnStart)
		}
		
		let method: String = "session-set"
		let arguments: Arguments
		
		struct Arguments: Encodable {
			let peerPortRandomOnStart: Bool
			
			enum CodingKeys: String, CodingKey {
				case peerPortRandomOnStart = "peer-port-random-on-start"
			}
		}
	}
	
	public static func setPortRandomOnStart(enabled: Bool) -> Data {
		try! encoder.encode(SetPortRandomOnStartBody(enabled))
	}
	
}

extension SessionBodies {
	
	private struct SetPortForwardingBody: Encodable {
		init(_ portForwardingEnabled: Bool) {
			arguments = Arguments(portForwardingEnabled: portForwardingEnabled)
		}
		
		let method: String = "session-set"
		let arguments: Arguments
		
		struct Arguments: Encodable {
			let portForwardingEnabled: Bool
			
			enum CodingKeys: String, CodingKey {
				case portForwardingEnabled = "port-forwarding-enabled"
			}
		}
	}
	
	public static func setPortForwarding(enabled: Bool) -> Data {
		try! encoder.encode(SetPortForwardingBody(enabled))
	}
	
}

extension SessionBodies {
	
	private struct SetBlocklistUrlBody: Encodable {
		init(_ blocklistUrl: String) {
			arguments = Arguments(blocklistUrl: blocklistUrl)
		}
		
		let method: String = "session-set"
		let arguments: Arguments
		
		struct Arguments: Encodable {
			let blocklistUrl: String
			
			enum CodingKeys: String, CodingKey {
				case blocklistUrl = "blocklist-url"
			}
		}
	}
	
	public static func setBlocklistUrl(url: String) -> Data {
		try! encoder.encode(SetBlocklistUrlBody(url))
	}
	
}

extension SessionBodies {
	
	private struct SetPeerLimitPerTorrentBody: Encodable {
		init(_ peerLimitPerTorrent: Int) {
			arguments = Arguments(peerLimitPerTorrent: peerLimitPerTorrent)
		}
		
		let method: String = "session-set"
		let arguments: Arguments
		
		struct Arguments: Encodable {
			let peerLimitPerTorrent: Int
			
			enum CodingKeys: String, CodingKey {
				case peerLimitPerTorrent = "peer-limit-per-torrent"
			}
		}
	}
	
	public static func setPeerLimitPerTorrent(limit: Int) -> Data {
		try! encoder.encode(SetPeerLimitPerTorrentBody(limit))
	}
	
}

extension SessionBodies {
	
	private struct SetGlobalPeerLimitBody: Encodable {
		init(_ peerLimitGlobal: Int) {
			arguments = Arguments(peerLimitGlobal: peerLimitGlobal)
		}
		
		let method: String = "session-set"
		let arguments: Arguments
		
		struct Arguments: Encodable {
			let peerLimitGlobal: Int
			
			enum CodingKeys: String, CodingKey {
				case peerLimitGlobal = "peer-limit-global"
			}
		}
	}
	
	public static func setGlobalPeerLimit(limit: Int) -> Data {
		try! encoder.encode(SetGlobalPeerLimitBody(limit))
	}
	
}

extension SessionBodies {
	
	private struct SetBlocklistEnabledBody: Encodable {
		init(_ blocklistEnabled: Bool) {
			arguments = Arguments(blocklistEnabled: blocklistEnabled)
		}
		
		let method: String = "session-set"
		let arguments: Arguments
		
		struct Arguments: Encodable {
			let blocklistEnabled: Bool
			
			enum CodingKeys: String, CodingKey {
				case blocklistEnabled = "blocklist-enabled"
			}
		}
	}
	
	public static func setBlocklistEnabled(enabled: Bool) -> Data {
		try! encoder.encode(SetBlocklistEnabledBody(enabled))
	}
	
}

extension SessionBodies {
	
	private struct SetLpdEnabledBody: Encodable {
		init(_ lpdEnabled: Bool) {
			arguments = Arguments(lpdEnabled: lpdEnabled)
		}
		
		let method: String = "session-set"
		let arguments: Arguments
		
		struct Arguments: Encodable {
			let lpdEnabled: Bool
			
			enum CodingKeys: String, CodingKey {
				case lpdEnabled = "lpd-enabled"
			}
		}
	}
	
	public static func setLpdEnabled(enabled: Bool) -> Data {
		try! encoder.encode(SetLpdEnabledBody(enabled))
	}
	
}

extension SessionBodies {
	
	private struct SetDhtEnabledBody: Encodable {
		init(_ dhtEnabled: Bool) {
			arguments = Arguments(dhtEnabled: dhtEnabled)
		}
		
		let method: String = "session-set"
		let arguments: Arguments
		
		struct Arguments: Encodable {
			let dhtEnabled: Bool
			
			enum CodingKeys: String, CodingKey {
				case dhtEnabled = "dht-enabled"
			}
		}
	}
	
	public static func setDhtEnabled(enabled: Bool) -> Data {
		try! encoder.encode(SetDhtEnabledBody(enabled))
	}
	
}

extension SessionBodies {
	
	private struct SetPexEnabledBody: Encodable {
		init(_ pexEnabled: Bool) {
			arguments = Arguments(pexEnabled: pexEnabled)
		}
		
		let method: String = "session-set"
		let arguments: Arguments
		
		struct Arguments: Encodable {
			let pexEnabled: Bool
			
			enum CodingKeys: String, CodingKey {
				case pexEnabled = "pex-enabled"
			}
		}
	}
	
	public static func setPexEnabled(enabled: Bool) -> Data {
		try! encoder.encode(SetPexEnabledBody(enabled))
	}
	
}

extension SessionBodies {
	
	private struct SetPeersEncryptionBody: Encodable {
		init(_ encryption: String) {
			arguments = Arguments(encryption: encryption)
		}
		
		let method: String = "session-set"
		let arguments: Arguments
		
		struct Arguments: Encodable {
			let encryption: String
			
			enum CodingKeys: String, CodingKey {
				case encryption = "encryption"
			}
		}
	}
	
	public static func setPeersEncryption(value: String) -> Data {
		try! encoder.encode(SetPeersEncryptionBody(value))
	}
	
}

extension SessionBodies {
	
	private struct SetAlternativeSpeedTimeEndBody: Encodable {
		init(_ altSpeedTimeEnd: Int) {
			arguments = Arguments(altSpeedTimeEnd: altSpeedTimeEnd)
		}
		
		let method: String = "session-set"
		let arguments: Arguments
		
		struct Arguments: Encodable {
			let altSpeedTimeEnd: Int
			
			enum CodingKeys: String, CodingKey {
				case altSpeedTimeEnd = "alt-speed-time-end"
			}
		}
	}
	
	public static func setAlternativeSpeedTimeEnd(hour: Int) -> Data {
		try! encoder.encode(SetAlternativeSpeedTimeEndBody(hour))
	}
	
}

extension SessionBodies {
	
	private struct SetAlternativeSpeedTimeBeginBody: Encodable {
		init(_ altSpeedTimeBegin: Int) {
			arguments = Arguments(altSpeedTimeBegin: altSpeedTimeBegin)
		}
		
		let method: String = "session-set"
		let arguments: Arguments
		
		struct Arguments: Encodable {
			let altSpeedTimeBegin: Int
			
			enum CodingKeys: String, CodingKey {
				case altSpeedTimeBegin = "alt-speed-time-begin"
			}
		}
	}
	
	public static func setAlternativeSpeedTimeBegin(hour: Int) -> Data {
		try! encoder.encode(SetAlternativeSpeedTimeBeginBody(hour))
	}
	
}
extension SessionBodies {
	
	private struct SetAlternativeSpeedTimeDayBody: Encodable {
		init(_ altSpeedTimeDay: Int) {
			arguments = Arguments(altSpeedTimeDay: altSpeedTimeDay)
		}
		
		let method: String = "session-set"
		let arguments: Arguments
		
		struct Arguments: Encodable {
			let altSpeedTimeDay: Int
			
			enum CodingKeys: String, CodingKey {
				case altSpeedTimeDay = "alt-speed-time-day"
			}
		}
	}
	
	public static func setAlternativeSpeedTimeDay(day: Int) -> Data {
		try! encoder.encode(SetAlternativeSpeedTimeDayBody(day))
	}
	
}

extension SessionBodies {
	
	private struct SetAlternativeSpeedDownBody: Encodable {
		init(_ altSpeedDown: Int) {
			arguments = Arguments(altSpeedDown: altSpeedDown)
		}
		
		let method: String = "session-set"
		let arguments: Arguments
		
		struct Arguments: Encodable {
			let altSpeedDown: Int
			
			enum CodingKeys: String, CodingKey {
				case altSpeedDown = "alt-speed-down"
			}
		}
	}
	
	public static func setAltSpeedDown(limit: Int) -> Data {
		try! encoder.encode(SetAlternativeSpeedDownBody(limit))
	}
	
}

extension SessionBodies {
	
	private struct SetAlternativeSpeedUpBody: Encodable {
		init(_ altSpeedUp: Int) {
			arguments = Arguments(altSpeedUp: altSpeedUp)
		}
		
		let method: String = "session-set"
		let arguments: Arguments
		
		struct Arguments: Encodable {
			let altSpeedUp: Int
			
			enum CodingKeys: String, CodingKey {
				case altSpeedUp = "alt-speed-up"
			}
		}
	}
	
	public static func setAltSpeedUp(limit: Int) -> Data {
		try! encoder.encode(SetAlternativeSpeedUpBody(limit))
	}
	
}

extension SessionBodies {
	
	private struct SetSpeedLimitDownBody: Encodable {
		init(_ speedLimitDown: Int) {
			arguments = Arguments(speedLimitDown: speedLimitDown)
		}
		
		let method: String = "session-set"
		let arguments: Arguments
		
		struct Arguments: Encodable {
			let speedLimitDown: Int
			
			enum CodingKeys: String, CodingKey {
				case speedLimitDown = "speed-limit-down"
			}
		}
	}
	
	public static func setSpeedLimitDown(limit: Int) -> Data {
		try! encoder.encode(SetSpeedLimitDownBody(limit))
	}
	
}

extension SessionBodies {
	
	private struct SetSpeedLimitUpBody: Encodable {
		init(_ speedLimitUp: Int) {
			arguments = Arguments(speedLimitUp: speedLimitUp)
		}
		
		let method: String = "session-set"
		let arguments: Arguments
		
		struct Arguments: Encodable {
			let speedLimitUp: Int
			
			enum CodingKeys: String, CodingKey {
				case speedLimitUp = "speed-limit-up"
			}
		}
	}
	
	public static func setSpeedLimitUp(limit: Int) -> Data {
		try! encoder.encode(SetSpeedLimitUpBody(limit))
	}
	
}

extension SessionBodies {
	
	private struct SetAltSpeedTimeEnabledBody: Encodable {
		init(_ altSpeedTimeEnabled: Bool) {
			arguments = Arguments(altSpeedTimeEnabled: altSpeedTimeEnabled)
		}
		
		let method: String = "session-set"
		let arguments: Arguments
		
		struct Arguments: Encodable {
			let altSpeedTimeEnabled: Bool
			
			enum CodingKeys: String, CodingKey {
				case altSpeedTimeEnabled = "alt-speed-time-enabled"
			}
		}
	}
	
	public static func setAltSpeedTimeEnabled(enabled: Bool) -> Data {
		try! encoder.encode(SetAltSpeedTimeEnabledBody(enabled))
	}
	
}

extension SessionBodies {
	
	private struct SetDownloadLimitEnabledBody: Encodable {
		init(_ speedLimitDownEnabled: Bool) {
			arguments = Arguments(speedLimitDownEnabled: speedLimitDownEnabled)
		}
		
		let method: String = "session-set"
		let arguments: Arguments
		
		struct Arguments: Encodable {
			let speedLimitDownEnabled: Bool
			
			enum CodingKeys: String, CodingKey {
				case speedLimitDownEnabled = "speed-limit-down-enabled"
			}
		}
	}
	
	public static func setDownloadLimitEnabled(enabled: Bool) -> Data {
		try! encoder.encode(SetDownloadLimitEnabledBody(enabled))
	}
	
}

extension SessionBodies {
	
	private struct SetUploadLimitEnabledBody: Encodable {
		init(_ speedLimitUpEnabled: Bool) {
			arguments = Arguments(speedLimitUpEnabled: speedLimitUpEnabled)
		}
		
		let method: String = "session-set"
		let arguments: Arguments
		
		struct Arguments: Encodable {
			let speedLimitUpEnabled: Bool
			
			enum CodingKeys: String, CodingKey {
				case speedLimitUpEnabled = "speed-limit-up-enabled"
			}
		}
	}
	
	public static func setUploadLimitEnabled(enabled: Bool) -> Data {
		try! encoder.encode(SetUploadLimitEnabledBody(enabled))
	}
	
}

extension SessionBodies {
	
	private struct SetDownloadDirBody: Encodable {
		init(_ downloadDir: String) {
			arguments = Arguments(downloadDir: downloadDir)
		}
		
		let method: String = "session-set"
		let arguments: Arguments
		
		struct Arguments: Encodable {
			let downloadDir: String
			
			enum CodingKeys: String, CodingKey {
				case downloadDir = "download-dir"
			}
		}
	}
	
	public static func setDownloadDir(downloadDir: String) -> Data {
		try! encoder.encode(SetDownloadDirBody(downloadDir))
	}
	
}

extension SessionBodies {
	
	private struct SetSeedRatioLimitedBody: Encodable {
		init(_ seedRatioLimited: Bool) {
			arguments = Arguments(seedRatioLimited: seedRatioLimited)
		}
		
		let method: String = "session-set"
		let arguments: Arguments
		
		struct Arguments: Encodable {
			let seedRatioLimited: Bool
			
			enum CodingKeys: String, CodingKey {
				case seedRatioLimited = "seedRatioLimited"
			}
		}
	}
	
	public static func setSeedRatioLimited(enabled: Bool) -> Data {
		try! encoder.encode(SetSeedRatioLimitedBody(enabled))
	}
	
}

extension SessionBodies {
	
	private struct SetSeedRatioLimitBody: Encodable {
		init(_ seedRatioLimit: Int) {
			arguments = Arguments(seedRatioLimit: seedRatioLimit)
		}
		
		let method: String = "session-set"
		let arguments: Arguments
		
		struct Arguments: Encodable {
			let seedRatioLimit: Int
			
			enum CodingKeys: String, CodingKey {
				case seedRatioLimit = "seedRatioLimit"
			}
		}
	}
	
	public static func setSeedRatioLimit(limit: Int) -> Data {
		try! encoder.encode(SetSeedRatioLimitBody(limit))
	}
	
}

extension SessionBodies {
	
	private struct SetIdleSeedingLimitEnabledBody: Encodable {
		init(_ idleSeedingLimitEnabled: Bool) {
			arguments = Arguments(idleSeedingLimitEnabled: idleSeedingLimitEnabled)
		}
		
		let method: String = "session-set"
		let arguments: Arguments
		
		struct Arguments: Encodable {
			let idleSeedingLimitEnabled: Bool
			
			enum CodingKeys: String, CodingKey {
				case idleSeedingLimitEnabled = "idle-seeding-limit-enabled"
			}
		}
	}
	
	public static func setIdleSeedingLimitEnabled(enabled: Bool) -> Data {
		try! encoder.encode(SetIdleSeedingLimitEnabledBody(enabled))
	}
	
}

extension SessionBodies {
	
	private struct SetIdleSeedingLimitBody: Encodable {
		init(_ idleSeedingLimit: Int) {
			arguments = Arguments(idleSeedingLimit: idleSeedingLimit)
		}
		
		let method: String = "session-set"
		let arguments: Arguments
		
		struct Arguments: Encodable {
			let idleSeedingLimit: Int
			
			enum CodingKeys: String, CodingKey {
				case idleSeedingLimit = "idle-seeding-limit"
			}
		}
	}
	
	public static func setIdleSeedingLimit(limit: Int) -> Data {
		try! encoder.encode(SetIdleSeedingLimitBody(limit))
	}
	
}

extension SessionBodies {
	
	private struct SetRenamePartialFileBody: Encodable {
		init(_ renamePartialFiles: Bool) {
			arguments = Arguments(renamePartialFiles: renamePartialFiles)
		}
		
		let method: String = "session-set"
		let arguments: Arguments
		
		struct Arguments: Encodable {
			let renamePartialFiles: Bool
			
			enum CodingKeys: String, CodingKey {
				case renamePartialFiles = "rename-partial-files"
			}
		}
	}
	
	public static func setRenamePartialFiles(enabled: Bool) -> Data {
		try! encoder.encode(SetRenamePartialFileBody(enabled))
	}
	
}

extension SessionBodies {
	
	private struct SetStartAddedTorrentsBody: Encodable {
		init(_ startAddedTorrents: Bool) {
			arguments = Arguments(startAddedTorrents: startAddedTorrents)
		}
		
		let method: String = "session-set"
		let arguments: Arguments
		
		struct Arguments: Encodable {
			let startAddedTorrents: Bool
			
			enum CodingKeys: String, CodingKey {
				case startAddedTorrents = "start-added-torrents"
			}
		}
	}
	
	public static func setStartAddedTorrents(enabled: Bool) -> Data {
		try! encoder.encode(SetStartAddedTorrentsBody(enabled))
	}
	
}

extension SessionBodies {
	
	private struct SessionGetBody: Encodable {
		init(_ fields: [String]) {
			arguments = Arguments(fields: fields)
		}
		
		let method: String = "session-get"
		let arguments: Arguments
		
		struct Arguments: Encodable {
			let fields: [String]
		}
	}
	
	public static func get(fields: [String]) -> Data {
		try! encoder.encode(SessionGetBody(fields))
	}
	
}

extension SessionBodies {
	private struct SetDownloadLimit: Encodable {
		init(enabled: Bool) {
			arguments = Arguments(altSpeedEnabled: enabled)
		}
		
		let method: String = "session-set"
		let arguments: Arguments
		
		struct Arguments: Encodable {
			let altSpeedEnabled: Bool
			
			enum CodingKeys: String, CodingKey {
				case altSpeedEnabled = "alt-speed-enabled"
			}
		}
	}
	
	public static func setDownloadLimit(enabled: Bool) -> Data {
		try! encoder.encode(SetDownloadLimit(enabled: enabled))
	}
}
