//
//  TorrentStopMapper.swift
//  Transmission
//
//  Created by Federico Arvat on 04/08/23.
//

import Foundation

public enum TorrentStopMapper {
	
	public enum Error: Swift.Error {
		case invalidData
	}
	
	public static func map(_ data: Data, from response: HTTPURLResponse) throws {
		guard response.isOK else {
			throw Error.invalidData
		}
	}
	
}
