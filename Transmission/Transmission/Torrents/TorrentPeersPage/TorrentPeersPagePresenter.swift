//
//  TorrentPeersPagePresenter.swift
//  Transmission
//
//  Created by Federico Arvat on 20/08/23.
//

import Foundation

public class TorrentPeersPagePresenter {
	
	public static var title: String {
		NSLocalizedString(
			"TITLE",
			tableName: "TorrentPeers",
			bundle: Bundle(for: TorrentPeersPagePresenter.self),
			comment: "Page title")
	}
	
	public static var percentage: String {
		NSLocalizedString(
			"PERCENTAGE",
			tableName: "TorrentPeers",
			bundle: Bundle(for: TorrentPeersPagePresenter.self),
			comment: "Item percentage description")
	}
	
	public static var status: String {
		NSLocalizedString(
			"STATUS",
			tableName: "TorrentPeers",
			bundle: Bundle(for: TorrentPeersPagePresenter.self),
			comment: "Item status description")
	}
	
	public static var client: String {
		NSLocalizedString(
			"CLIENT",
			tableName: "TorrentPeers",
			bundle: Bundle(for: TorrentPeersPagePresenter.self),
			comment: "Item client description")
	}
	
	public static func map(_ torrentPeers: [TorrentPeer], decimalSeparator: String? = nil) -> TorrentPeersPageViewModel {
		TorrentPeersPageViewModel(
			peers: torrentPeers.map {
				TorrentPeersPageViewModel.Peer(
					percentage: (($0.progress * 100).round(decimalSeparator: decimalSeparator) ?? "-") + "%",
					status: $0.status,
					address: $0.address,
					client: $0.clientName
				)
			}
		)
	}
}
