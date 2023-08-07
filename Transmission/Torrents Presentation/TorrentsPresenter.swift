//
//  TorrentsPresenter.swift
//  Transmission
//
//  Created by Federico Arvat on 18/07/23.
//

import Foundation

public final class TorrentsPresenter {
	public static var title: String {
		NSLocalizedString(
			"TORRENTS_VIEW_TITLE",
			tableName: "Torrents",
			bundle: Bundle(for: TorrentsPresenter.self),
			comment: "Title for the torrents view")
	}
}
