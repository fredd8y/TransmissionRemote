//
//  TorrentsViewModel+Factory.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 24/07/23.
//

import Transmission

extension TorrentsViewModel {
	static var empty: TorrentsViewModel {
		TorrentsPresenter.map(title: TorrentsPresenter.title, error: nil, uploadSpeed: 0, downloadSpeed: 0, torrents: [])
	}
	
	static var error: TorrentsViewModel {
		TorrentsPresenter.map(title: TorrentsPresenter.title, error: TorrentsPresenter.undefinedError, uploadSpeed: 0, downloadSpeed: 0, torrents: [])
	}
}
