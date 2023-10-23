//
//  TorrentsPresenterTests.swift
//  TransmissionTests
//
//  Created by Federico Arvat on 19/07/23.
//

import XCTest
import Transmission

final class TorrentsPresenterTests: XCTorrentTestCase {
	
	private let table = "Torrents"
	
	func test_title_isLocalized() {
		XCTAssertEqual(TorrentsPagePresenter.title, localized("TORRENTS_VIEW_TITLE", table: table))
	}
	
	func test_torrents_isLocalized() {
		XCTAssertEqual(TorrentsPagePresenter.torrents, localized("TORRENTS", table: table))
	}
	
	func test_torrent_isLocalized() {
		XCTAssertEqual(TorrentsPagePresenter.torrent, localized("TORRENT", table: table))
	}
	
	func test_credentialRequired_isLocalized() {
		XCTAssertEqual(TorrentsPagePresenter.credentialRequired, localized("CREDENTIAL_NEEDED_TITLE", table: table))
	}
	
	func test_ok_isLocalized() {
		XCTAssertEqual(TorrentsPagePresenter.ok, localized("OK", table: table))
	}
	
	func test_undefinedError_isLocalized() {
		XCTAssertEqual(TorrentsPagePresenter.undefinedError, localized("UNDEFINED_ERROR", table: table))
	}
	
	func test_serverNotSet_isLocalized() {
		XCTAssertEqual(TorrentsPagePresenter.serverNotSet, localized("SERVER_NOT_SET", table: table))
	}
	
	func test_filePermissionError_isLocalized() {
		XCTAssertEqual(TorrentsPagePresenter.filePermissionError, localized("FILE_PERMISSION_ERRROR", table: table))
	}
	
	func test_itemAlreadyAdded_isLocalized() {
		XCTAssertEqual(TorrentsPagePresenter.itemAlreadyAdded, localized("ITEM_ALREADY_ADDED_ERROR", table: table))
	}
	
	func test_genericError_isLocalized() {
		XCTAssertEqual(TorrentsPagePresenter.genericError, localized("GENERIC_ERROR", table: table))
	}
	
	func test_deleteTorrentAlertTitle_isLocalized() {
		XCTAssertEqual(TorrentsPagePresenter.deleteTorrentAlertTitle, localized("DELETE_TORRENT_ALERT_TITLE", table: table))
	}
	
	func test_deleteTorrentAlertMessage_isLocalized() {
		XCTAssertEqual(TorrentsPagePresenter.deleteTorrentAlertMessage, localized("DELETE_TORRENT_ALERT_MESSAGE", table: table))
	}
	
	func test_deleteAllTorrentAlertMessage_isLocalized() {
		XCTAssertEqual(TorrentsPagePresenter.deleteAllTorrentAlertMessage, localized("DELETE_ALL_TORRENT_ALERT_MESSAGE", table: table))
	}
	
	func test_deleteLocalData_isLocalized() {
		XCTAssertEqual(TorrentsPagePresenter.deleteLocalData, localized("DELETE_LOCAL_DATA", table: table))
	}
	
	func test_keepLocalData_isLocalized() {
		XCTAssertEqual(TorrentsPagePresenter.keepLocalData, localized("KEEP_LOCAL_DATA", table: table))
	}
	
	func test_cancel_isLocalized() {
		XCTAssertEqual(TorrentsPagePresenter.cancel, localized("CANCEL", table: table))
	}
	
	func test_remove_isLocalized() {
		XCTAssertEqual(TorrentsPagePresenter.remove, localized("REMOVE", table: table))
	}
	
	func test_stop_isLocalized() {
		XCTAssertEqual(TorrentsPagePresenter.stop, localized("STOP", table: table))
	}
	
	func test_linkTitle_isLocalized() {
		XCTAssertEqual(TorrentsPagePresenter.linkTitle, localized("LINK_TITLE", table: table))
	}
	
	func test_linkPlaceholder_isLocalized() {
		XCTAssertEqual(TorrentsPagePresenter.linkPlaceholder, localized("LINK_PLACEHOLDER", table: table))
	}
	
	func test_linkInsertDescription_isLocalized() {
		XCTAssertEqual(TorrentsPagePresenter.linkInsertDescription, localized("LINK_INSERT_DESCRIPTION", table: table))
	}
	
	func test_link_isLocalized() {
		XCTAssertEqual(TorrentsPagePresenter.link, localized("LINK", table: table))
	}
	
	func test_serverTimeout_isLocalized() {
		XCTAssertEqual(TorrentsPagePresenter.serverTimeout, localized("SERVER_TIMEOUT", table: table))
	}
	
	func test_missingServerError_isLocalized() {
		XCTAssertEqual(TorrentsPagePresenter.missingServerError, localized("MISSING_SERVER_ERROR", table: table))
	}
	
	func test_emptyTorrentListMessage_isLocalized() {
		XCTAssertEqual(TorrentsPagePresenter.emptyTorrentListMessage, localized("EMPTY_TORRENT_LIST_MESSAGE", table: table))
	}
	
	func test_lockTo_isLocalized() {
		XCTAssertEqual(TorrentsPagePresenter.lockTo, localized("LOCK_TO", table: table))
	}
	
	func test_up_isLocalized() {
		XCTAssertEqual(TorrentsPagePresenter.up, localized("UP", table: table))
	}
	
	func test_down_isLocalized() {
		XCTAssertEqual(TorrentsPagePresenter.down, localized("DOWN", table: table))
	}
	
	func test_unlockSpeedLimit_isLocalized() {
		XCTAssertEqual(TorrentsPagePresenter.unlockSpeedLimit, localized("UNLOCK_SPEED_LIMIT", table: table))
	}
	
	func test_stopAll_isLocalized() {
		XCTAssertEqual(TorrentsPagePresenter.stopAll, localized("STOP_ALL", table: table))
	}
	
	func test_startAll_isLocalized() {
		XCTAssertEqual(TorrentsPagePresenter.startAll, localized("START_ALL", table: table))
	}
	
	func test_removeAll_isLocalized() {
		XCTAssertEqual(TorrentsPagePresenter.removeAll, localized("REMOVE_ALL", table: table))
	}
	
    func test_closeTorrentDetail_isLocalized() {
        XCTAssertEqual(TorrentsPagePresenter.closeTorrentDetail, localized("CLOSE_TORRENT_DETAIL", table: table))
    }
    
	func test_connectionUnavailable_isLocalized() {
		XCTAssertEqual(TorrentsPagePresenter.connectionUnavailable, localized("CONNECTION_UNAVAILABLE", table: table))
	}
	
	func test_serverUnreachable_isLocalized() {
		XCTAssertEqual(TorrentsPagePresenter.serverUnreachable, localized("SERVER_UNREACHABLE", table: table))
	}
	
	func test_map_createsViewModel() {
		let title = "Title"
		let isLoading = false
		let error = "a error"
		let uploadSpeed = 1234576
		let downloadSpeed = 1234567
		let temporaryUploadSpeed = 50
		let temporaryDownloadSpeed = 50
		let temporarySpeedEnabled = true
		let torrent1 = anyTorrentWithoutError()
		let torrent2 = anyTorrentWithError()
		let torrents = [torrent1, torrent2]
		let freeDiskSpace = 1234567
		let emptyMessage = "a message"
		let canAddTorrent = true
		let alertMessage = "alert message"
		let alertMessageVisibile = false

		let viewModel = TorrentsPagePresenter.map(
			title: title,
			isLoading: isLoading,
			error: error,
			uploadSpeed: uploadSpeed,
			downloadSpeed: downloadSpeed,
			temporaryUploadSpeed: temporaryUploadSpeed,
			temporaryDownloadSpeed: temporaryDownloadSpeed,
			temporarySpeedEnabled: temporarySpeedEnabled,
			torrents: torrents,
			freeDiskSpace: freeDiskSpace,
			emptyMessage: emptyMessage,
			canAddTorrent: canAddTorrent,
			alertMessage: alertMessage,
			alertMessageVisible: alertMessageVisibile,
			decimalSeparator: ","
		)

		XCTAssertEqual(viewModel.title, title)
		XCTAssertEqual(viewModel.isLoading, isLoading)
		XCTAssertEqual(viewModel.error, error)
		XCTAssertEqual(viewModel.downloadSpeed, "1,18 MB/s")
		XCTAssertEqual(viewModel.uploadSpeed, "1,18 MB/s")
		XCTAssertEqual(viewModel.torrents.count, 2)
		XCTAssertEqual(viewModel.freeDiskSpace, "\(TorrentsPagePresenter.freeSpace) 1,18 MB")
		XCTAssertEqual(viewModel.emptyMessage, emptyMessage)
		XCTAssertEqual(viewModel.canAddTorrent, canAddTorrent)
		XCTAssertEqual(viewModel.alertMessage, alertMessage)
		XCTAssertEqual(viewModel.alertMessageVisible, alertMessageVisibile)
	}
}

