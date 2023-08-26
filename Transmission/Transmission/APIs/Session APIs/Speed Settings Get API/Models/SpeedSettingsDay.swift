//
//  SpeedSettingsDay.swift
//  Transmission
//
//  Created by Federico Arvat on 25/08/23.
//

import Foundation

public enum SpeedSettingsDay: Int, CaseIterable {
	case everyday = 127
	case weekdays = 62
	case weekends = 65
	case sunday = 1
	case monday = 2
	case tuesday = 4
	case wednesday = 8
	case thursday = 16
	case friday = 32
	case saturday = 64
}
