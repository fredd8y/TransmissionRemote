//
//  ServerDetailPageViewModel.swift
//  Transmission
//
//  Created by Federico Arvat on 30/07/23.
//

import Foundation

public class ServerDetailPageViewModel {
	public init(
		title: String,
		name: String? = nil,
		`protocol`: String? = nil,
		ip: String? = nil,
		port: Int? = nil,
		username: String? = nil,
		password: String? = nil
	) {
		self.title = title
		self.name = name
		self.`protocol` = `protocol`
		self.ip = ip
		self.port = port
		self.username = username
		self.password = password
	}
	
	public var title: String
	public var name: String?
	public var `protocol`: String?
	public var ip: String?
	public var port: Int?
	public var username: String?
	public var password: String?
}
