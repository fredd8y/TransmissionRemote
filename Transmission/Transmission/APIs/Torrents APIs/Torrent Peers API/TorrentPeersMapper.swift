//
//  TorrentPeersMapper.swift
//  Transmission
//
//  Created by Federico Arvat on 20/08/23.
//

import Foundation

public enum TorrentPeersMapper {
	
	public enum Error: Swift.Error {
		case invalidData
	}
	
	public static func map(_ data: Data, from response: HTTPURLResponse) throws -> [TorrentPeer] {
		guard response.isOK, let remoteTorrentPeers = try? JSONDecoder().decode(RemoteTorrentPeers.self, from: data) else {
			throw Error.invalidData
		}
		if remoteTorrentPeers.arguments.torrents.count <= 0 || remoteTorrentPeers.arguments.torrents.count > 1 {
			throw Error.invalidData
		}
		return remoteTorrentPeers.peers
	}
	
	private struct RemoteTorrentPeers: Decodable {
		let arguments: Arguments
		let result: String
		
		struct Arguments: Decodable {
			let torrents: [Torrent]
			
			struct Torrent: Decodable {
				let peers: [Peer]
				
				struct Peer: Decodable {
					let address: String
					let clientIsChoked: Bool
					let clientIsInterested: Bool
					let clientName: String
					let flagStr: String
					let isDownloadingFrom: Bool
					let isEncrypted: Bool
					let isIncoming: Bool
					let isUTP: Bool
					let isUploadingTo: Bool
					let peerIsChoked: Bool
					let peerIsInterested: Bool
					let port: Int
					let progress: Double
					let rateToClient: Int
					let rateToPeer: Int
				}
			}
		}
		
		var peers: [TorrentPeer] {
			let torrent = arguments.torrents.first!
			return torrent.peers.map {
				TorrentPeer(progress: $0.progress, status: $0.flagStr, address: $0.address, clientName: $0.clientName)
			}
		}
	}
	
}

