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
			bundle: Bundle(for: TorrentDetailPresenter.self),
			comment: "Page title")
	}
	
	public static func map(_ torrentPeers: [TorrentPeer]) -> TorrentPeersPageViewModel {
		TorrentPeersPageViewModel(
			peers: torrentPeers.map {
				TorrentPeersPageViewModel.Peer(
					percentage: (($0.progress * 100).round() ?? "-") + "%",
					status: $0.status,
					address: $0.address,
					client: $0.clientName
				)
			}
		)
	}
}
