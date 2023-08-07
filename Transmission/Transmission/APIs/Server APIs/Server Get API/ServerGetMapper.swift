//
//  ServerGetMapper.swift
//  Transmission
//
//  Created by Federico Arvat on 28/07/23.
//

import Foundation

public final class ServerGetMapper {
	
	public enum Error: Swift.Error {
		case invalidData
	}
	
	public static func map(_ data: Data) throws -> [Server] {
		guard let remoteServerList = try? JSONDecoder().decode([RemoteServer].self, from: data) else {
			throw Error.invalidData
		}
		return remoteServerList.map { $0.server }
	}
	
}
