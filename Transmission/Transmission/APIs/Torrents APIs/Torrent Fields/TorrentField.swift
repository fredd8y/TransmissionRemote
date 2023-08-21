//
//  TorrentField.swift
//  Transmission
//
//  Created by Federico Arvat on 26/07/23.
//

import Foundation

public enum TorrentField {
	static let activityDate = "activityDate"
	static let addedDate = "addedDate"
	static let availability = "availability"
	static let bandwidthPriority = "bandwidthPriority"
	static let comment = "comment"
	static let corruptEver = "corruptEver"
	static let creator = "creator"
	static let dateCreated = "dateCreated"
	static let desiredAvailable = "desiredAvailable"
	static let doneDate = "doneDate"
	static let downloadDir = "downloadDir"
	static let downloadedEver = "downloadedEver"
	static let downloadLimit = "downloadLimit"
	static let downloadLimited = "downloadLimited"
	static let editDate = "editDate"
	static let error = "error"
	static let errorString = "errorString"
	static let eta = "eta"
	static let etaIdle = "etaIdle"
	static let file = "file"
	static let files = "files"
	static let fileStats = "fileStats"
	static let group = "group"
	static let hashString = "hashString"
	static let haveUnchecked = "haveUnchecked"
	static let haveValid = "haveValid"
	static let honorsSessionLimits = "honorsSessionLimits"
	static let id = "id"
	static let isFinished = "isFinished"
	static let isPrivate = "isPrivate"
	static let isStalled = "isStalled"
	static let labels = "labels"
	static let leftUntilDone = "leftUntilDone"
	static let magnetLink = "magnetLink"
	static let manualAnnounceTime = "manualAnnounceTime"
	static let maxConnectedPeers = "maxConnectedPeers"
	static let metadataPercentComplete = "metadataPercentComplete"
	static let name = "name"
	static let peer = "peer"
	static let peers = "peers"
	static let peersConnected = "peersConnected"
	static let peersFrom = "peersFrom"
	static let peersGettingFromUs = "peersGettingFromUs"
	static let peersSendingToUs = "peersSendingToUs"
	static let percentComplete = "percentComplete"
	static let percentDone = "percentDone"
	static let pieces = "pieces"
	static let pieceCount = "pieceCount"
	static let pieceSize = "pieceSize"
	static let priorities = "priorities"
	static let primary = "primary"
	static let queuePosition = "queuePosition"
	static let rateDownload = "rateDownload"
	static let rateUpload = "rateUpload"
	static let recheckProgress = "recheckProgress"
	static let secondsDownloading = "secondsDownloading"
	static let secondsSeeding = "secondsSeeding"
	static let seedIdleLimit = "seedIdleLimit"
	static let seedIdleMode = "seedIdleMode"
	static let seedRatioLimit = "seedRatioLimit"
	static let seedRatioMode = "seedRatioMode"
	static let sequentialDownload = "sequentialDownload"
	static let sizeWhenDone = "sizeWhenDone"
	static let startDate = "startDate"
	static let status = "status"
	static let trackers = "trackers"
	static let trackerList = "trackerList"
	static let trackerStats = "trackerStats"
	static let totalSize = "totalSize"
	static let torrentFile = "torrentFile"
	static let uploadedEver = "uploadedEver"
	static let uploadLimit = "uploadLimit"
	static let uploadLimited = "uploadLimited"
	static let uploadRatio = "uploadRatio"
	static let wanted = "wanted"
	static let webseeds = "webseeds"
	static let webseedsSendingToU = "webseedsSendingToU"
	
	public static var minimumTorrentField: [String] {
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
	
	public static var torrentDetailField: [String] {
		return [
			id,
			eta,
			name,
			error,
			peers,
			status,
			startDate,
			isPrivate,
			totalSize,
			fileStats,
			haveValid,
			hashString,
			rateUpload,
			downloadDir,
			uploadRatio,
			errorString,
			percentDone,
			corruptEver,
			uploadedEver,
			rateDownload,
			activityDate,
			trackerStats,
			haveUnchecked,
			downloadedEver,
			desiredAvailable
		]
	}
	
	public static var torrentPeers: [String] {
		return [peers]
	}
}
