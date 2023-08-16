//
//  CreditsPagePresenter.swift
//  Transmission
//
//  Created by Federico Arvat on 16/08/23.
//

import Foundation

public class CreditsPagePresenter {
	public static var title: String {
		NSLocalizedString(
			"CREDITS_PAGE_TITLE",
			tableName: "CreditsPage",
			bundle: Bundle(for: CreditsPagePresenter.self),
			comment: "Credits page title")
	}
	
	public static var turtleIconCredit: String {
		NSLocalizedString(
			"TURTLE_ICON_CREDITS",
			tableName: "CreditsPage",
			bundle: Bundle(for: CreditsPagePresenter.self),
			comment: "Turtle icon credit")
	}
}
