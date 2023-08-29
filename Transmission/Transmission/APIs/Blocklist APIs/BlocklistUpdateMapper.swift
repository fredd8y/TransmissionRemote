//
//  BlocklistUpdateMapper.swift
//  Transmission
//
//  Created by Federico Arvat on 28/08/23.
//

import Foundation

public enum BlocklistUpdateMapper {
	
	public enum Error: Swift.Error {
		case invalidData
		case failed(explanation: String)
	}
	
	public static func map(_ data: Data, from response: HTTPURLResponse) throws -> Int? {
		guard response.isOK, let remoteResponse = try? JSONDecoder().decode(RemoteResponse.self, from: data) else {
			throw Error.invalidData
		}
		if remoteResponse.result != SharedAPIsConstants.success {
			throw Error.failed(explanation: remoteResponse.result)
		}
		return remoteResponse.arguments.blocklistSize
	}
	
	private struct RemoteResponse: Decodable {
		let arguments: Arguments
		let result: String
		
		struct Arguments: Decodable {
			let blocklistSize: Int?
			
			enum CodingKeys: String, CodingKey {
				case blocklistSize = "blocklist-size"
			}
		}
	}
	
}
