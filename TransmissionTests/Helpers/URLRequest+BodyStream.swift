//
//  URLRequest+BodyStream.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 11/05/23.
//

import Foundation

extension URLRequest {
	var bodyStreamData: Data? {
		guard let bodyStream = httpBodyStream else { return nil }
		bodyStream.open()
		let bufferSize: Int = 16
		let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: bufferSize)
		var data = Data()
		while bodyStream.hasBytesAvailable {
			let readData = bodyStream.read(buffer, maxLength: bufferSize)
			data.append(buffer, count: readData)
		}
		buffer.deallocate()
		bodyStream.close()
		return data
	}
}
