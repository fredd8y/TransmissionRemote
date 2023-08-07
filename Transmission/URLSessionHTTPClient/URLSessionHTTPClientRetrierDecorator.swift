//
//  URLSessionHTTPClientRetrierDecorator.swift
//  Transmission
//
//  Created by Federico Arvat on 17/07/23.
//

import Foundation

public class URLSessionHTTPClientRetrierDecorator: URLSessionHTTPClient {
	
	public static var sessionIdKey: String {
		return "X-Transmission-Session-Id"
	}
	
	private let decoratee: URLSessionHTTPClient
	
	public init(decoratee: URLSessionHTTPClient) {
		self.decoratee = decoratee
		super.init(session: decoratee.session)
	}
	
	public enum Error: Swift.Error, Equatable {
		case missingSessionId(sessionIdValue: Any?)
		
		public static func == (lhs: URLSessionHTTPClientRetrierDecorator.Error, rhs: URLSessionHTTPClientRetrierDecorator.Error) -> Bool {
			switch (lhs, rhs) {
			case (.missingSessionId, .missingSessionId):
				return true
			}
		}
	}
	
	public override func post(_ url: URL, body: Data, username: String, password: String, sessionId: String?, completion: @escaping (Result<(Data, HTTPURLResponse), Swift.Error>) -> Void) -> URLSessionTask {
		super.post(
			url,
			body: body,
			username: username,
			password: password,
			sessionId: sessionId,
			completion: { result in
				if let (_, response) = try? result.get(), response.isMissingSessionId {
					completion(.failure(Error.missingSessionId(sessionIdValue: response.allHeaderFields[URLSessionHTTPClientRetrierDecorator.sessionIdKey])))
				} else {
					completion(result)
				}
			}
		)
	}
}
