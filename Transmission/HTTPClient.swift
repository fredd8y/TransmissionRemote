//
//  HTTPClient.swift
//  Transmission
//
//  Created by Federico Arvat on 11/05/23.
//

import Foundation

public protocol HTTPClient {
	/// The completion handler can be invoked in any thread.
	/// Clients are responsible to dispatch to appropriate threads, if needed.
	@discardableResult
	func post(
		_ url: URL,
		body: Data,
		completion: @escaping (Result<(Data, HTTPURLResponse), Error>) -> Void
	) -> URLSessionTask
}
