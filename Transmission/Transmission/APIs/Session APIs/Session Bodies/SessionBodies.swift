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
