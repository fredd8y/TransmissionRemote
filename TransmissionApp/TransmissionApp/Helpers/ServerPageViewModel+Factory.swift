//
//  ServerPageViewModel+Factory.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 30/07/23.
//

import Transmission

extension ServerPageViewModel {
	static func empty() -> ServerPageViewModel {
		ServerPageViewModel(
			title: ServerPagePresenter.title,
			servers: [],
			editItemActionTitle: ServerPagePresenter.editItemActionTitle,
			deleteItemActionTitle: ServerPagePresenter.deleteItemActionTitle,
			currentSelectedServerId: nil,
			emptyMessage: ServerPagePresenter.serverPageEmptyMessage,
			alertMessage: nil,
			alertMessageVisible: false
		)
	}
}
