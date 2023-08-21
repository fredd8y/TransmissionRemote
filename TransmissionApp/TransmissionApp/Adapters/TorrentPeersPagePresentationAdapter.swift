//
//  TorrentPeersPagePresentationAdapter.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 21/08/23.
//

import Combine
import SwiftUI
import Transmission
import TransmissioniOS

final class TorrentPeersPagePresentationAdapter {
	
	init(torrentPeersPageViewModel: TorrentPeersPageViewModel) {
		self.torrentPeersPageViewModel = torrentPeersPageViewModel
	}
	
	private var id: Int!
	
	@ObservedObject private var torrentPeersPageViewModel: TorrentPeersPageViewModel
	
	private var workItems: [DispatchWorkItem] = []
	private var cancellables = Set<AnyCancellable>()
	
	func showTorrentPeers(_ id: Int) -> TorrentPeersPage {
		self.id = id
		return TorrentPeersPage(viewModel: torrentPeersPageViewModel)
	}
	
	func stopLoadingData() {
		cancelCurrentLoadingTasks()
	}
	
	func loadData() {
		cancelCurrentLoadingTasks()
		guard let server = UserDefaultsHandler.shared.currentServer else {
			return
		}
		TransmissionHTTPClient.makeTorrentPeersLoader(id: id, server: server)
			.dispatchOnMainQueue()
			.sink(
				receiveCompletion: { completion in
					switch completion {
					case .finished:
						break
					case .failure(let error):
						print(error)
						break
					}
				},
				receiveValue: { [weak self] torrentPeers in
					let viewModel = TorrentPeersPagePresenter.map(torrentPeers)
					self?.torrentPeersPageViewModel.newValues(viewModel)
					let workItem = DispatchWorkItem { [weak self] in
						self?.loadData()
					}
					self?.workItems.append(workItem)
					DispatchQueue.main.asyncAfter(deadline: .now() + DispatchTimeInterval.seconds(UserDefaultsHandler.shared.pollingRate), execute: workItem)
				}
			)
			.store(in: &cancellables)
	}
	
	private func cancelCurrentLoadingTasks() {
		workItems.forEach { $0.cancel() }
		workItems.removeAll()
		cancellables.removeAll()
	}
	
}

private extension TorrentPeersPageViewModel {
	func newValues(_ viewModel: TorrentPeersPageViewModel) {
		peers = viewModel.peers
	}
}
