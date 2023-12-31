//
//  TransmissionComposer.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 24/07/23.
//

import Combine
import SwiftUI
import Transmission
import TransmissioniOS


final class TransmissionComposer {
	
	private init() {}
	
	private static var cancellable: Cancellable?
	
	public static func containerView() -> TabContainer {
		let torrentsPage = torrentsPage()
		let serverPage = serverPage()
		let settingsPage = settingsPage(serverPage: serverPage)
		
		return TabContainer(torrentsPage: torrentsPage, settingsPage: settingsPage)
	}
	
	private static func torrentsPage() -> TorrentsPage {
		let torrentsPageViewModel = TorrentsPageViewModel.loading()
		
		var torrentsPage = TorrentsPage(viewModel: torrentsPageViewModel)

		let torrentsPagePresentationAdapter = TorrentsPagePresentationAdapter(
			torrentsPageViewModel: torrentsPageViewModel,
			sessionIdHandler: { sessionId in
				TransmissionHTTPClient.sessionId = sessionId
			}
		)
		
		torrentsPage.stop = torrentsPagePresentationAdapter.stop
		torrentsPage.start = torrentsPagePresentationAdapter.start
		torrentsPage.delete = torrentsPagePresentationAdapter.delete
		torrentsPage.stopAll = torrentsPagePresentationAdapter.stopAll
		torrentsPage.onAppear = {
			torrentDetailContainers.removeAll()
			torrentsPagePresentationAdapter.loadData()
		}
		torrentsPage.startAll = torrentsPagePresentationAdapter.startAll
		torrentsPage.onRefresh = torrentsPagePresentationAdapter.loadData
		torrentsPage.deleteAll = torrentsPagePresentationAdapter.deleteAll
		torrentsPage.selectedFile = torrentsPagePresentationAdapter.selectedFile
		torrentsPage.selectedLink = torrentsPagePresentationAdapter.selectedLink
		torrentsPage.onDisappear = torrentsPagePresentationAdapter.stopLoadingData
		torrentsPage.onOpenDetail = torrentsPagePresentationAdapter.stopLoadingData
		torrentsPage.setDownloadLimit = torrentsPagePresentationAdapter.setDownloadLimit
		torrentsPage.selectedTorrent = torrentDetailContainer
		
		return torrentsPage
	}
	
	private static var torrentDetailContainers: [Int: TorrentDetailTabContainer] = [:]
	
	private static func torrentDetailContainer(_ id: Int) -> TorrentDetailTabContainer {
		// This is a workaround that has to be done due to a bug in SwiftUI that cause a multiple call on
		// navigationDestination(for:) in this case inside TorrentsPage. This method being called multiple
		// times cause a problem in the ViewModel/View binding causing the page to not receive the viewModel update.
		// To avoid this behaviour I've created a map to return the previously created TorrentDetailTabContainer if available.
		// This workaround is done with the help of this stackoverflow answer:
		// https://stackoverflow.com/a/74722075/9539895
		// This torrentDetailContainers map has to be cleaned when the TorrentDetailTabContainer is being dismissed,
		// otherwise if you open and close a lot of torrent detail you end up having a lot of old pages in memory
		// that are no longer necessary. To free this map we use the
		// onAppear method that the TorrentsPage expose, given the fact that when the TorrentsPage is visible the
		// TorrentDetailTabContainer must be dismissed because is the only entry point
		if let torrentDetailContainer = torrentDetailContainers[id] {
			return torrentDetailContainer
		} else {
			let torrentDetailPagePresentationAdapter = TorrentDetailPagePresentationAdapter(torrentDetailPageViewModel: .empty())
			var torrentDetailPage = torrentDetailPagePresentationAdapter.showTorrentDetail(id)
			torrentDetailPage.onAppear = torrentDetailPagePresentationAdapter.loadData
			torrentDetailPage.onDisappear = torrentDetailPagePresentationAdapter.stopLoadingData
			
			let torrentPeersPagePresentationAdapter = TorrentPeersPagePresentationAdapter(torrentPeersPageViewModel: .empty())
			var torrentPeersPage = torrentPeersPagePresentationAdapter.showTorrentPeers(id)
			torrentPeersPage.onAppear = torrentPeersPagePresentationAdapter.loadData
			torrentPeersPage.onDisappear = torrentPeersPagePresentationAdapter.stopLoadingData
			
			let torrentTrackersPagePresentationAdapter = TorrentTrackersPagePresentationAdapter(torrentTrackersPageViewModel: .empty())
			var torrentTrackersPage = torrentTrackersPagePresentationAdapter.showTorrentTrackers(id)
			torrentTrackersPage.onAppear = torrentTrackersPagePresentationAdapter.loadData
			torrentTrackersPage.onDisappear = torrentTrackersPagePresentationAdapter.stopLoadingData
			
			let torrentDetailContainer = TorrentDetailTabContainer(
				torrentDetailPage: torrentDetailPage,
				torrentPeersPage: torrentPeersPage,
				torrentTrackersPage: torrentTrackersPage
			)
			torrentDetailContainers[id] = torrentDetailContainer
			return torrentDetailContainer
		}
	}
	
	private static func settingsPage(serverPage: ServerPage) -> SettingsPage {
		let settingsPageViewModel = SettingsPageViewModel.empty()
		
		let settingsPagePresentationAdapter = SettingsPagePresentationAdapter(
			settingsViewModel: settingsPageViewModel
		)
				
		let torrentsSettingsPagePresentationAdapter = TorrentsSettingsPagePresentationAdapter()
		let speedSettingsPagePresentationAdapter = SpeedSettingsPagePresentationAdapter()
		let peersSettingsPagePresentationAdapter = PeersSettingsPagePresentationAdapter()
		let networkSettingsPagePresentationAdapter = NetworkSettingsPagePresentationAdapter()
		
		var settingsPage = SettingsPage(viewModel: settingsPageViewModel, serverPage: serverPage)
		settingsPage.loadData = settingsPagePresentationAdapter.loadData
		settingsPage.pollingRateSelected = settingsPagePresentationAdapter.selectedPollingRate
		settingsPage.torrentsSettingsSelected = {
			var torrentsSettingsPage = torrentsSettingsPagePresentationAdapter.showTorrentsSettingsPage()
			torrentsSettingsPage.onAppear = torrentsSettingsPagePresentationAdapter.loadData
			torrentsSettingsPage.onRefresh = torrentsSettingsPagePresentationAdapter.loadData
			torrentsSettingsPage.onDisappear = torrentsSettingsPagePresentationAdapter.stopLoadingData
			torrentsSettingsPage.onDownloadDirChange = torrentsSettingsPagePresentationAdapter.setDownloadDir
			torrentsSettingsPage.onSeedRatioLimitChange = torrentsSettingsPagePresentationAdapter.setSeedRatioLimit
			torrentsSettingsPage.onIdleSeedingLimitChange = torrentsSettingsPagePresentationAdapter.setIdleSeedingLimit
			torrentsSettingsPage.onSeedRatioLimitedChange = torrentsSettingsPagePresentationAdapter.setSeedRatioLimited
			torrentsSettingsPage.onStartAddedTorrentChange = torrentsSettingsPagePresentationAdapter.setStartAddedTorrent
			torrentsSettingsPage.onRenamePartialFilesChange = torrentsSettingsPagePresentationAdapter.setRenamePartialFiles
			torrentsSettingsPage.onIdleSeedingLimitEnabledChange = torrentsSettingsPagePresentationAdapter.setIdleSeedingLimitEnabled
			return torrentsSettingsPage
		}
		
		settingsPage.speedSettingsSelected = {
			var speedSettingsPage = speedSettingsPagePresentationAdapter.showSpeedSettingsPage()
			speedSettingsPage.onAppear = speedSettingsPagePresentationAdapter.loadData
			speedSettingsPage.onRefresh = speedSettingsPagePresentationAdapter.loadData
			speedSettingsPage.onDisappear = speedSettingsPagePresentationAdapter.stopLoadingData
			speedSettingsPage.onUploadLimitEnabledChange = speedSettingsPagePresentationAdapter.uploadLimitEnabledChange
			speedSettingsPage.onDownloadLimitEnabledChange = speedSettingsPagePresentationAdapter.downloadLimitEnabledChange
			speedSettingsPage.onScheduledTimesEnabledChange = speedSettingsPagePresentationAdapter.scheduledTimesEnabledChange
			speedSettingsPage.onUploadLimit = speedSettingsPagePresentationAdapter.uploadLimit
			speedSettingsPage.onDownloadLimit = speedSettingsPagePresentationAdapter.downloadLimit
			speedSettingsPage.onAlternativeUploadLimit = speedSettingsPagePresentationAdapter.alternativeUploadLimit
			speedSettingsPage.onAlternativeDownloadLimit = speedSettingsPagePresentationAdapter.alternativeDownloadLimit
			speedSettingsPage.dayName = speedSettingsPagePresentationAdapter.dayName
			speedSettingsPage.onAlternativeSpeedTimeBeginChange = speedSettingsPagePresentationAdapter.alternativeSpeedTimeBeginChange
			speedSettingsPage.onAlternativeSpeedTimeEndChange = speedSettingsPagePresentationAdapter.alternativeSpeedTimeEndChange
			speedSettingsPage.onAlternativeSpeedTimeDayChange = speedSettingsPagePresentationAdapter.alternativeSpeedTimeDayChange
			return speedSettingsPage
		}
		
		settingsPage.peersSettingsSelected = {
			var peersSettingsPage = peersSettingsPagePresentationAdapter.showPeersSettingsPage()
			peersSettingsPage.onAppear = peersSettingsPagePresentationAdapter.loadData
			peersSettingsPage.onRefresh = peersSettingsPagePresentationAdapter.loadData
			peersSettingsPage.onDisappear = peersSettingsPagePresentationAdapter.stopLoadingData
			peersSettingsPage.encryptionDescription = peersSettingsPagePresentationAdapter.encryptionDescription
			peersSettingsPage.onEncryptionChange = peersSettingsPagePresentationAdapter.onEncryptionChange
			peersSettingsPage.onPexEnabledChange = peersSettingsPagePresentationAdapter.onPexEnabledChange
			peersSettingsPage.onDhtEnabledChange = peersSettingsPagePresentationAdapter.onDhtEnabledChange
			peersSettingsPage.onLpdEnabledChange = peersSettingsPagePresentationAdapter.onLpdEnabledChange
			peersSettingsPage.onBlocklistEnabledChange = peersSettingsPagePresentationAdapter.onBlocklistEnabledChange
			peersSettingsPage.onUpdateTapped = peersSettingsPagePresentationAdapter.onBlocklistUpdate
			peersSettingsPage.onPeerLimitGlobalChange = peersSettingsPagePresentationAdapter.onPeerLimitGlobalChange
			peersSettingsPage.onPeerLimitPerTorrentChange = peersSettingsPagePresentationAdapter.onPeerLimitPerTorrentChange
			peersSettingsPage.onBlocklistUrlChange = peersSettingsPagePresentationAdapter.onBlocklistUrlChange
			return peersSettingsPage
		}
		
		settingsPage.networkSettingsSelected = {
			var networkSettingsPage = networkSettingsPagePresentationAdapter.showNetworkSettingsPage()
			networkSettingsPage.onAppear = networkSettingsPagePresentationAdapter.loadData
			networkSettingsPage.onRefresh = networkSettingsPagePresentationAdapter.loadData
			networkSettingsPage.onDisappear = networkSettingsPagePresentationAdapter.stopLoadingData
			networkSettingsPage.onPeerPortRandomOnStartChange = networkSettingsPagePresentationAdapter.peerPortRandomOnStartChange
			networkSettingsPage.onPortForwardingEnabledChange = networkSettingsPagePresentationAdapter.portForwardingEnabledChange
			networkSettingsPage.onUtpEnabledChange = networkSettingsPagePresentationAdapter.utpEnabledChange
			networkSettingsPage.onListeningPortChange = networkSettingsPagePresentationAdapter.listeningPortChange
			return networkSettingsPage
		}
		
		return settingsPage
	}
	
	private static func serverPage() -> ServerPage {
		let viewModel = ServerPageViewModel.empty()
		
		let serverPagePresentationAdapter = ServerPagePresentationAdapter(
			serversViewModel: viewModel
		)
		let serverDetailPresentationAdapter = ServerDetailPagePresentationAdapter()
		
		var serverPage = ServerPage(viewModel: viewModel)
		
		serverPage.selectServer = serverPagePresentationAdapter.selectServer
		serverPage.loadData = serverPagePresentationAdapter.loadData
		serverPage.deleteServer = serverPagePresentationAdapter.delete
		
		serverPage.showServerDetail = serverDetailPresentationAdapter.showServerDetail
		serverPage.newServer = serverDetailPresentationAdapter.newServer
		
		return serverPage
	}
	
}
