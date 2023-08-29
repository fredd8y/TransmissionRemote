//
//  PortTestMapper.swift
//  Transmission
//
//  Created by Federico Arvat on 29/08/23.
//

import Foundation

public enum PortTestMapper {
	
	public enum Error: Swift.Error {
		case invalidData
	}
	
	public static func map(_ data: Data, from response: HTTPURLResponse) throws -> Bool {
		guard response.isOK, let remoteResponse = try? JSONDecoder().decode(RemoteResponse.self, from: data) else {
			throw Error.invalidData
		}
		return remoteResponse.arguments.portIsOpen
	}
	
	private struct RemoteResponse: Decodable {
		let arguments: Arguments
		let result: String
		
		struct Arguments: Decodable {
			let portIsOpen: Bool
			
			enum CodingKeys: String, CodingKey {
				case portIsOpen = "port-is-open"
			}
		}
	}
	
}
