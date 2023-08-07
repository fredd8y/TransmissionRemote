//
//  ServerFile.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 02/08/23.
//

import Foundation

enum ServerFile {
	static let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appending(component: "servers.json")
}
