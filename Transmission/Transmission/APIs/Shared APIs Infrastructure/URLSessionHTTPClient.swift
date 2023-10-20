//
//  URLSessionHTTPClient.swift
//  Transmission
//
//  Created by Federico Arvat on 11/05/23.
//

import Foundation

public class URLSessionHTTPClient: HTTPClient {
	
	let session: URLSession
	
	public init(session: URLSession) {
		self.session = session
	}
	
	public func post(
		_ url: URL,
		body: Data,
		additionalHeader: [String: String]?,
		completion: @escaping (Result<(Data, HTTPURLResponse), Error>) -> Void
	) -> URLSessionTask {
		var urlRequest = URLRequest(url: url)
		urlRequest.httpMethod = "POST"
		urlRequest.httpBody = body
        urlRequest.timeoutInterval = 10
		additionalHeader?.forEach { (key, value) in
			urlRequest.addValue(value, forHTTPHeaderField: key)
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
