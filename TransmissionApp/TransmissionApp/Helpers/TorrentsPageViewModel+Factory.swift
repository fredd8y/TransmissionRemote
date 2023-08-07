//
//  TorrentsPageViewModel+Factory.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 24/07/23.
//

import Transmission

extension TorrentsPageViewModel {
	static func empty() -> TorrentsPageViewModel {
		TorrentsPagePresenter.map(
			title: TorrentsPagePresenter.title,
			error: nil,
			uploadSpeed: 0,
			downloadSpeed: 0,
			torrents: [],
			emptyMessage: nil
		)
	}
	
	static func error() -> TorrentsPageViewModel {
		TorrentsPagePresenter.map(
			title: TorrentsPagePresenter.title,
			error: TorrentsPagePresenter.undefinedError,
			uploadSpeed: 0,
			downloadSpeed: 0,
			torrents: [],
			emptyMessage: nil
		)
	}
	
	static func serverNotSet() -> TorrentsPageViewModel {
		TorrentsPagePresenter.map(
			title: TorrentsPagePresenter.title,
			error: nil,
			uploadSpeed: 0,
			downloadSpeed: 0,
			torrents: [],
			emptyMessage: TorrentsPagePresenter.serverNotSet
		)
	}
	
	static func credentialRequired() -> TorrentsPageViewModel {
		TorrentsPagePresenter.map(
			title: TorrentsPagePresenter.title,
			error: TorrentsPagePresenter.credentialRequired,
			uploadSpeed: 0,
			downloadSpeed: 0,
			torrents: [],
			emptyMessage: nil
		)
	}
	
}
