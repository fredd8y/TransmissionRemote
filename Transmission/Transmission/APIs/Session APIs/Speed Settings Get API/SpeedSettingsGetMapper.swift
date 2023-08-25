//
//  SpeedSettingsGetMapper.swift
//  Transmission
//
//  Created by Federico Arvat on 25/08/23.
//

import Foundation

public enum SpeedSettingsGetMapper {
	
	public enum Error: Swift.Error {
		case invalidData
	}
	
	public static func map(_ json: Data, from response: HTTPURLResponse) throws -> SpeedSettings {
		guard response.isOK, let remoteTorrentsSettings = try? JSONDecoder().decode(RemoteSpeedSettings.self, from: json) else {
			throw Error.invalidData
		}
		return remoteTorrentsSettings.speedSettings
	}
	
	
	private struct RemoteSpeedSettings: Decodable {
		private let arguments: Arguments
		
		private struct Arguments:  Decodable {
			let altSpeedDown: Int
			let altSpeedTimeBegin: Int
			let altSpeedTimeDay: Int
			let altSpeedTimeEnabled: Bool
			let altSpeedTimeEnd: Int
			let altSpeedUp: Int
			let speedLimitDownEnabled: Bool
			let speedLimitDown: Int
			let speedLimitUpEnabled: Bool
			let speedLimitUp: Int
			
			enum CodingKeys: String, CodingKey {
				case altSpeedDown = "alt-speed-down"
				case altSpeedTimeBegin = "alt-speed-time-begin"
				case altSpeedTimeDay = "alt-speed-time-day"
				case altSpeedTimeEnabled = "alt-speed-time-enabled"
				case altSpeedTimeEnd = "alt-speed-time-end"
				case altSpeedUp = "alt-speed-up"
				case speedLimitDownEnabled = "speed-limit-down-enabled"
				case speedLimitDown = "speed-limit-down"
				case speedLimitUpEnabled = "speed-limit-up-enabled"
				case speedLimitUp = "speed-limit-up"
			}
		}
		
		var speedSettings: SpeedSettings {
			SpeedSettings(
				altSpeedDown: arguments.altSpeedDown,
				altSpeedTimeBegin: arguments.altSpeedTimeBegin,
				altSpeedTimeDay: arguments.altSpeedTimeDay,
				altSpeedTimeEnabled: arguments.altSpeedTimeEnabled,
				altSpeedTimeEnd: arguments.altSpeedTimeEnd,
				altSpeedUp: arguments.altSpeedUp,
				speedLimitDownEnabled: arguments.speedLimitDownEnabled,
				speedLimitDown: arguments.speedLimitDown,
				speedLimitUpEnabled: arguments.speedLimitUpEnabled,
				speedLimitUp: arguments.speedLimitUp
			)
		}
	}
	
}
