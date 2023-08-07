//
//  HTTPURLResponse+StatusCode.swift
//  Transmission
//
//  Created by Federico Arvat on 14/05/23.
//

import Foundation

extension HTTPURLResponse {
	private static var OK_200: Int { return 200 }
	
	private static var MISSING_SESSION_ID: Int { return 409 }
	
	var isOK: Bool {
		return statusCode == HTTPURLResponse.OK_200
	}
	
	var isMissingSessionId: Bool {
		return statusCode == HTTPURLResponse.MISSING_SESSION_ID
	}
}
