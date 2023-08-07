//
//  URLSessionHTTPClient.swift
//  Transmission
//
//  Created by Federico Arvat on 11/05/23.
//

import Foundation

public final class URLSessionHTTPClient: HTTPClient {
	let session: URLSession
	
	public init(session: URLSession) {
		self.session = session
	}
	
	public func post(
		_ url: URL,
		body: Data,
		completion: @escaping (Result<(Data, HTTPURLResponse), Error>) -> Void
	) -> URLSessionTask {
		var urlRequest = URLRequest(url: url)
		urlRequest.httpMethod = "POST"
		urlRequest.httpBody = body
		
		let task = session.dataTask(with: urlRequest) { data, response, error in
			if let error {
				completion(.failure(error))
			}
		}
		task.resume()
		return task
	}
}
