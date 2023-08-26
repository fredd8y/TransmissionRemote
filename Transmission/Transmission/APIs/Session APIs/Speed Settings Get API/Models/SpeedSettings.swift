//
//  SpeedSettings.swift
//  Transmission
//
//  Created by Federico Arvat on 25/08/23.
//

import Foundation

public struct SpeedSettings: Equatable {
	public init(
		altSpeedDown: Int,
		altSpeedTimeBegin: Int,
		altSpeedTimeDay: Int,
		altSpeedTimeEnabled: Bool,
		altSpeedTimeEnd: Int,
		altSpeedUp: Int,
		speedLimitDownEnabled: Bool,
		speedLimitDown: Int,
		speedLimitUpEnabled: Bool,
		speedLimitUp: Int
	) {
		self.altSpeedDown = altSpeedDown
		self.altSpeedTimeBegin = altSpeedTimeBegin
		self.altSpeedTimeDay = altSpeedTimeDay
		self.altSpeedTimeEnabled = altSpeedTimeEnabled
		self.altSpeedTimeEnd = altSpeedTimeEnd
		self.altSpeedUp = altSpeedUp
		self.speedLimitDownEnabled = speedLimitDownEnabled
		self.speedLimitDown = speedLimitDown
		self.speedLimitUpEnabled = speedLimitUpEnabled
		self.speedLimitUp = speedLimitUp
	}
	
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
}
