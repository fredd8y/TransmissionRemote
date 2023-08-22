//
//  TorrentsSettingsGetMapper.swift
//  Transmission
//
//  Created by Federico Arvat on 22/08/23.
//

import Foundation

public enum TorrentsSettingsGetMapper {
	
	public enum Error: Swift.Error {
		case invalidData
	}
	
	public static func map(_ json: Data, from response: HTTPURLResponse) throws -> TorrentsSettings {
		guard response.isOK, let remoteTorrentsSettings = try? JSONDecoder().decode(RemoteTorrentsSettings.self, from: json) else {
			throw Error.invalidData
		}
		return remoteTorrentsSettings.torrentsSettings
	}
	
	
	private struct RemoteTorrentsSettings: Decodable {
		private let arguments: Arguments
		
		private struct Arguments:  Decodable {
			let downloadDir: String
			let startAddedTorrents: Bool
			let renamePartialFiles: Bool
			let seedRatioLimited: Bool
			let seedRatioLimit: Int
			let idleSeedingLimitEnabled: Bool
			let idleSeedingLimit: Int
			
			enum CodingKeys: String, CodingKey {
				case downloadDir = "download-dir"
				case startAddedTorrents = "start-added-torrents"
				case renamePartialFiles = "rename-partial-files"
				case seedRatioLimited = "seedRatioLimited"
				case seedRatioLimit = "seedRatioLimit"
				case idleSeedingLimitEnabled = "idle-seeding-limit-enabled"
				case idleSeedingLimit = "idle-seeding-limit"
			}
		}
		
		var torrentsSettings: TorrentsSettings {
			TorrentsSettings(
				downloadDir: arguments.downloadDir,
				startAddedTorrents: arguments.startAddedTorrents,
				renamePartialFiles: arguments.renamePartialFiles,
				seedRatioLimited: arguments.seedRatioLimited,
				seedRatioLimit: arguments.seedRatioLimit,
				idleSeedingLimitEnabled: arguments.idleSeedingLimitEnabled,
				idleSeedingLimit: arguments.idleSeedingLimit
			)
		}
	}
	
}
