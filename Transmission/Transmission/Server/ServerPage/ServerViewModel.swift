//
//  ServerViewModel.swift
//  Transmission
//
//  Created by Federico Arvat on 29/07/23.
//

import Foundation

public class ServerViewModel: Identifiable, Equatable {
	
	public init(
		title: String,
		url: String,
		id: UUID
	) {
		self.title = title
		self.url = url
		self.id = id
	}
	
	public var title: String
	public var url: String
	public var id: UUID
	
	public static func == (lhs: ServerViewModel, rhs: ServerViewModel) -> Bool {
		lhs.title == rhs.title && lhs.url == rhs.url && lhs.id == rhs.id
	}
	
}
