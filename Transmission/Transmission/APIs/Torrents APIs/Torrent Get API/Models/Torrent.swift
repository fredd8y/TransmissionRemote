//
//  Torrent.swift
//  Transmission
//
//  Created by Federico Arvat on 17/05/23.
//

import Foundation

public struct Torrent: Equatable {
	
	public init(
		name: String,
		error: Int,
		errorString: String,
		eta: Int,
		id: Int,
		isFinished: Bool,
		percentDone: Double,
		rateDownload: Int,
		rateUpload: Int,
		totalSize: Int,
		status: Status
	) {
		self.name = name
		self.error = error
		self.errorString = errorString
		self.eta = eta
		self.id = id
		self.isFinished = isFinished
		self.percentDone = percentDone
		self.rateDownload = rateDownload
		self.rateUpload = rateUpload
		self.totalSize = totalSize
		self.status = status
	}

	public let name: String
	public let error: Int
	public let errorString: String
	public let eta: Int
	public let id: Int
	public let isFinished: Bool
	public let percentDone: Double
	public let rateDownload: Int
	public let rateUpload: Int
	public let totalSize: Int
	public let status: Status
	
}
