//
//  URLSessionHTTPClient.swift
//  Transmission
//
//  Created by Federico Arvat on 11/05/23.
//

import Foundation

public class URLSessionHTTPClient: HTTPClient {
	
	private let BASIC = "Basic"
	private let AUTHORIZATION = "Authorization"
	
	let session: URLSession
	
	public init(session: URLSession) {
		self.session = session
	}
	
	public func post(
		_ url: URL,
		body: Data,
		username: String,
		password: String,
		sessionId: String?,
		completion: @escaping (Result<(Data, HTTPURLResponse), Error>) -> Void
	) -> URLSessionTask {
		var urlRequest = URLRequest(url: url)
		urlRequest.httpMethod = "POST"
		urlRequest.httpBody = body
		let authorizationString = "\(username):\(password)".data(using: .utf8)!.base64EncodedString()
		urlRequest.addValue(
			"\(BASIC) \(authorizationString)",
			forHTTPHeaderField: AUTHORIZATION
		)
		if let sessionId {
			urlRequest.addValue(sessionId, forHTTPHeaderField: URLSessionHTTPClientRetrierDecorator.sessionIdKey)
		}
		
		let task = session.dataTask(with: urlRequest) { data, response, error in
			if let error {
				completion(.failure(error))
			} else if let data, let httpUrlResponse = (response as? HTTPURLResponse) {
				completion(.success((data, httpUrlResponse)))
			} else {
				completion(.failure(UnexpectedValuesError()))
			}
		}
		task.resume()
		return task
	}
	
	private struct UnexpectedValuesError: Error {}
}
