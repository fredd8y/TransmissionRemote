//
//  TorrentRemoveMapper.swift
//  Transmission
//
//  Created by Federico Arvat on 03/08/23.
//

import Foundation

public enum TorrentRemoveMapper {
	
	public enum Error: Swift.Error {
		case invalidData
	}
	
	public static func map(_ data: Data, from response: HTTPURLResponse) throws {
		guard response.isOK else {
			throw Error.invalidData
		}
	}
	
}