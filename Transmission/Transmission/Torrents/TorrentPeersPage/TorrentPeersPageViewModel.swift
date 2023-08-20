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
		
		let percentage: String
		let status: String
		let address: String
		let client: String
		
	}
	
}
