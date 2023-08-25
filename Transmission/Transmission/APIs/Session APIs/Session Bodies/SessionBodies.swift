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
		try! JSONEncoder().encode(SetAlternativeSpeedDownBody(limit))
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
		try! JSONEncoder().encode(SetAlternativeSpeedUpBody(limit))
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
		try! JSONEncoder().encode(SetSpeedLimitDownBody(limit))
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
		try! JSONEncoder().encode(SetSpeedLimitUpBody(limit))
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
		try! JSONEncoder().encode(SetAltSpeedTimeEnabledBody(enabled))
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
		try! JSONEncoder().encode(SetDownloadLimitEnabledBody(enabled))
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
		try! JSONEncoder().encode(SetUploadLimitEnabledBody(enabled))
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
		try! JSONEncoder().encode(SetDownloadDirBody(downloadDir))
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
		try! JSONEncoder().encode(SetSeedRatioLimitedBody(enabled))
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
		try! JSONEncoder().encode(SetSeedRatioLimitBody(limit))
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
		try! JSONEncoder().encode(SetIdleSeedingLimitEnabledBody(enabled))
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
		try! JSONEncoder().encode(SetIdleSeedingLimitBody(limit))
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
		try! JSONEncoder().encode(SetRenamePartialFileBody(enabled))
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
		try! JSONEncoder().encode(SetStartAddedTorrentsBody(enabled))
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
		try! JSONEncoder().encode(SessionGetBody(fields))
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
		try! JSONEncoder().encode(SetDownloadLimit(enabled: enabled))
	}
}
