//
//  TorrentsPageViewModel+Factory.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 24/07/23.
//

import Transmission

extension TorrentsPageViewModel {
	static func loading() -> TorrentsPageViewModel {
		TorrentsPagePresenter.map(
			title: TorrentsPagePresenter.title,
			isLoading: true,
			error: nil,
			uploadSpeed: 0,
			downloadSpeed: 0,
			temporaryUploadSpeed: 0,
			temporaryDownloadSpeed: 0,
			temporarySpeedEnabled: false,
			torrents: [],
			freeDiskSpace: nil,
			emptyMessage: nil,
			canAddTorrent: false,
			alertMessage: nil,
			alertMessageVisible: false
		)
	}
	
	static func error() -> TorrentsPageViewModel {
		TorrentsPagePresenter.map(
			title: TorrentsPagePresenter.title,
			isLoading: false,
			error: TorrentsPagePresenter.undefinedError,
			uploadSpeed: 0,
			downloadSpeed: 0,
			temporaryUploadSpeed: 0,
			temporaryDownloadSpeed: 0,
			temporarySpeedEnabled: false,
			torrents: [],
			freeDiskSpace: nil,
			emptyMessage: nil,
			canAddTorrent: false,
			alertMessage: nil,
			alertMessageVisible: false
		)
	}
	
	static func serverNotSet() -> TorrentsPageViewModel {
		TorrentsPagePresenter.map(
			title: TorrentsPagePresenter.title,
			isLoading: false,
			error: nil,
			uploadSpeed: 0,
			downloadSpeed: 0,
			temporaryUploadSpeed: 0,
			temporaryDownloadSpeed: 0,
			temporarySpeedEnabled: false,
			torrents: [],
			freeDiskSpace: nil,
			emptyMessage: TorrentsPagePresenter.serverNotSet,
			canAddTorrent: false,
			alertMessage: nil,
			alertMessageVisible: false
		)
	}
	
	static func credentialRequired() -> TorrentsPageViewModel {
		TorrentsPagePresenter.map(
			title: TorrentsPagePresenter.title,
			isLoading: false,
			error: TorrentsPagePresenter.credentialRequired,
			uploadSpeed: 0,
			downloadSpeed: 0,
			temporaryUploadSpeed: 0,
			temporaryDownloadSpeed: 0,
			temporarySpeedEnabled: false,
			torrents: [],
			freeDiskSpace: nil,
			emptyMessage: nil,
			canAddTorrent: false,
			alertMessage: nil,
			alertMessageVisible: false
		)
	}
	
    static func serverTimeout() -> TorrentsPageViewModel {
        TorrentsPagePresenter.map(
            title: TorrentsPagePresenter.title,
            isLoading: false,
            error: TorrentsPagePresenter.serverTimeout,
            uploadSpeed: 0,
            downloadSpeed: 0,
            temporaryUploadSpeed: 0,
            temporaryDownloadSpeed: 0,
            temporarySpeedEnabled: false,
            torrents: [],
            freeDiskSpace: nil,
            emptyMessage: nil,
            canAddTorrent: false,
            alertMessage: nil,
            alertMessageVisible: false
        )
    }
    
	static func connectionUnavailable() -> TorrentsPageViewModel {
		TorrentsPagePresenter.map(
			title: TorrentsPagePresenter.title,
			isLoading: false,
			error: TorrentsPagePresenter.connectionUnavailable,
			uploadSpeed: 0,
			downloadSpeed: 0,
			temporaryUploadSpeed: 0,
			temporaryDownloadSpeed: 0,
			temporarySpeedEnabled: false,
			torrents: [],
			freeDiskSpace: nil,
			emptyMessage: nil,
			canAddTorrent: false,
			alertMessage: nil,
			alertMessageVisible: false
		)
	}
	
}
