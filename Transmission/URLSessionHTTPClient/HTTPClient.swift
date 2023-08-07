//
//  HTTPClient.swift
//  Transmission
//
//  Created by Federico Arvat on 11/05/23.
//

import Foundation

public protocol HTTPClient {
	
	typealias Result = Swift.Result<(Data, HTTPURLResponse), Error>
	
	/// The completion handler can be invoked in any thread.
	/// Clients are responsible to dispatch to appropriate threads, if needed.
	@discardableResult
	func post(
		_ url: URL,
		body: Data,
		additionalHeader: [String: String]?,
		completion: @escaping (Result) -> Void
	) -> URLSessionTask
}
