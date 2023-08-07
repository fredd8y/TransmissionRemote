//
//  TorrentsViewModel+Factory.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 24/07/23.
//

import Transmission

extension TorrentsViewModel {
	static func empty() -> TorrentsViewModel {
		TorrentsPresenter.map(
			title: TorrentsPresenter.title,
			error: nil,
			uploadSpeed: 0,
			downloadSpeed: 0,
			torrents: [],
			emptyMessage: nil
		)
	}
	
	static func error() -> TorrentsViewModel {
		TorrentsPresenter.map(
			title: TorrentsPresenter.title,
			error: TorrentsPresenter.undefinedError,
			uploadSpeed: 0,
			downloadSpeed: 0,
			torrents: [],
			emptyMessage: nil
		)
	}
	
	static func serverNotSet() -> TorrentsViewModel {
		TorrentsPresenter.map(
			title: TorrentsPresenter.title,
			error: nil,
			uploadSpeed: 0,
			downloadSpeed: 0,
			torrents: [],
			emptyMessage: TorrentsPresenter.serverNotSet
		)
	}
}
