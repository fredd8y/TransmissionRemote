//
//  TorrentField+FieldGroups.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 22/08/23.
//

import Foundation
import Transmission

extension TorrentField {
	static var minimumTorrentField: [String] {
		return [
			id,
			eta,
			name,
			error,
			status,
			totalSize,
			rateUpload,
			isFinished,
			errorString,
			percentDone,
			rateDownload
		]
	}
	
	static var torrentDetailField: [String] {
		return [
			eta,
			name,
			status,
			startDate,
			isPrivate,
			totalSize,
			hashString,
			downloadDir,
			uploadRatio,
			errorString,
			percentDone,
			uploadedEver,
			activityDate,
			downloadedEver
		]
	}
	
	static var torrentPeers: [String] {
		return [peers]
	}
	
	static var torrentTrackers: [String] {
		return [trackerStats]
	}
}
