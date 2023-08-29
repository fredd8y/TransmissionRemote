//
//  PeersSettingsGetMapper.swift
//  Transmission
//
//  Created by Federico Arvat on 28/08/23.
//

import Foundation

public enum PeersSettingsGetMapper {
	
	public enum Error: Swift.Error {
		case invalidData
	}
	
	public static func map(_ json: Data, from response: HTTPURLResponse) throws -> PeersSettings {
		guard response.isOK, let remotePeersSettings = try? JSONDecoder().decode(RemotePeersSettings.self, from: json) else {
			throw Error.invalidData
		}
		return remotePeersSettings.peersSettings
	}
	
	
	private struct RemotePeersSettings: Decodable {
		private let arguments: Arguments
		
		struct Arguments:  Decodable {
			let peerLimitGlobal: Int
			let peerLimitPerTorrent: Int
			let pexEnabled: Bool
			let dhtEnabled: Bool
			let lpdEnabled: Bool
			let blocklistEnabled: Bool
			let blocklistSize: Int
			let blocklistUrl: String
			let encryption: Encryption
			
			enum CodingKeys: String, CodingKey {
				case peerLimitGlobal = "peer-limit-global"
				case peerLimitPerTorrent = "peer-limit-per-torrent"
				case pexEnabled = "pex-enabled"
				case dhtEnabled = "dht-enabled"
				case lpdEnabled = "lpd-enabled"
				case blocklistEnabled = "blocklist-enabled"
				case blocklistSize = "blocklist-size"
				case blocklistUrl = "blocklist-url"
				case encryption = "encryption"
			}
			
			enum Encryption: String, Decodable {
				case required
				case preferred
				case tolerated
				
				var peersSettingsEncryption: PeersSettings.Encryption {
					switch self {
					case .preferred: return .preferred
					case .required: return .required
					case .tolerated: return .tolerated
					}
				}
			}
		}
		
		var peersSettings: PeersSettings {
			PeersSettings(
				peerLimitGlobal: arguments.peerLimitGlobal,
				peerLimitPerTorrent: arguments.peerLimitPerTorrent,
				pexEnabled: arguments.pexEnabled,
				dhtEnabled: arguments.dhtEnabled,
				lpdEnabled: arguments.lpdEnabled,
				blocklistEnabled: arguments.blocklistEnabled,
				blocklistSize: arguments.blocklistSize,
				blocklistUrl: arguments.blocklistUrl,
				encryption: arguments.encryption.peersSettingsEncryption
			)
		}
	}
	
}
