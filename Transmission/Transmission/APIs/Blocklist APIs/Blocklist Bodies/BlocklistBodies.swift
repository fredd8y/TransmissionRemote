//
//  BlocklistBodies.swift
//  Transmission
//
//  Created by Federico Arvat on 28/08/23.
//

import Foundation

public enum BlocklistBodies {
	public static let update = #"{"method": "blocklist-update"}"#.data(using: .utf8)!
}
