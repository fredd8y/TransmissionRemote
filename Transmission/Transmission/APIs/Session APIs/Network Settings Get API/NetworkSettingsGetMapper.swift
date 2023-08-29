//
//  NetworkSettingsGetMapper.swift
//  Transmission
//
//  Created by Federico Arvat on 29/08/23.
//

import Foundation

public enum NetworkSettingsGetMapper {
	
	public enum Error: Swift.Error {
		case invalidData
	}
	
	public static func map(_ json: Data, from response: HTTPURLResponse) throws -> NetworkSettings {
		guard response.isOK, let remoteNetworkSettings = try? JSONDecoder().decode(RemoteNetworkSettings.self, from: json) else {
			throw Error.invalidData
		}
		return remoteNetworkSettings.networkSettings
	}
	
	private struct RemoteNetworkSettings: Decodable {
		private let arguments: Arguments
		
		struct Arguments:  Decodable {
			let peerPort: Int
			let peerPortRandomOnStart: Bool
			let portForwardingEnabled: Bool
			let utpEnabled: Bool
			
			enum CodingKeys: String, CodingKey {
				case peerPort = "peer-port"
				case peerPortRandomOnStart = "peer-port-random-on-start"
				case portForwardingEnabled = "port-forwarding-enabled"
				case utpEnabled = "utp-enabled"
			}
		}
		
		var networkSettings: NetworkSettings {
			NetworkSettings(
				peerPort: arguments.peerPort,
				peerPortRandomOnStart: arguments.peerPortRandomOnStart,
				portForwardingEnabled: arguments.portForwardingEnabled,
				utpEnabled: arguments.utpEnabled
			)
		}
	}
	
}
