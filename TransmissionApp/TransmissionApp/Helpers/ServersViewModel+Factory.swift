//
//  ServersViewModel+Factory.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 30/07/23.
//

import Transmission

extension ServersViewModel {
	static func empty() -> ServersViewModel {
		ServersViewModel(
			title: ServersPresenter.title,
			servers: [],
			currentSelectedServer: nil
		)
	}
}
