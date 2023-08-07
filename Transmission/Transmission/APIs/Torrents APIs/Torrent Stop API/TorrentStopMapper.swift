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
		case failed(explanation: String)
	}
	
	public static func map(_ data: Data, from response: HTTPURLResponse) throws {
		guard response.isOK, let remoteResponse = try? JSONDecoder().decode(RemoteResponse.self, from: data) else {
			throw Error.invalidData
		}
		if remoteResponse.result != SharedAPIsConstants.success {
			throw Error.failed(explanation: remoteResponse.result)
		}
	}
	
	private struct RemoteResponse: Decodable {
		let result: String
	}
	
}
