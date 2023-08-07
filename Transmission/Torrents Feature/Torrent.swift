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
		totalSize: Int
	) {
		self.name = name
		self.error = error
		self.errorString = errorString
		self.eta = eta
		self.id = id
		self.isFinished = isFinished
		self.percentDone = percentDone
		self.rateDownload = rateDownload
		self.totalSize = totalSize
	}

	let name: String
	let error: Int
	let errorString: String
	let eta: Int
	let id: Int
	let isFinished: Bool
	let percentDone: Double
	let rateDownload: Int
	let totalSize: Int
}
