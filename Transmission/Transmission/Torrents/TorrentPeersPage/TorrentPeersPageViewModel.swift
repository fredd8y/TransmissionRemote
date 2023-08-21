//
//  TorrentPeersPageViewModel.swift
//  Transmission
//
//  Created by Federico Arvat on 20/08/23.
//

import Foundation

public class TorrentPeersPageViewModel: ObservableObject {
	
	public init(peers: [Peer]) {
		self.peers = peers
	}
	
	@Published public var peers: [Peer]
	
	public class Peer {
		
		public init(percentage: String, status: String, address: String, client: String) {
			self.percentage = percentage
			self.status = status
			self.address = address
			self.client = client
		}
		
		public let percentage: String
		public let status: String
		public let address: String
		public let client: String
		
	}
	
}
