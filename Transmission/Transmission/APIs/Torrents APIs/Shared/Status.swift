//
//  Status.swift
//  Transmission
//
//  Created by Federico Arvat on 17/08/23.
//

import Foundation

public enum Status: Equatable {
	
	public init(_ status: Int) {
		switch status {
		case 0: self = .stopped
		case 1: self = .queuedVerifyLocalData
		case 2: self = .verifyingLocalData
		case 3: self = .queuedDownload
		case 4: self = .downloading
		case 5: self = .queuedToSeed
		case 6: self = .seeding
		default: self = .unknown
		}
	}
	
	case stopped
	case queuedVerifyLocalData
	case verifyingLocalData
	case queuedDownload
	case downloading
	case queuedToSeed
	case seeding
	case unknown
}
