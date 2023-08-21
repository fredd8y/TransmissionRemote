//
//  TorrentTrackersPagePresentationAdapter.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 21/08/23.
//

import Combine
import SwiftUI
import Transmission
import TransmissioniOS

final class TorrentTrackersPagePresentationAdapter {
	
	init(torrentTrackersPageViewModel: TorrentTrackersPageViewModel) {
		self.torrentTrackersPageViewModel = torrentTrackersPageViewModel
	}
	
	private var id: Int!
	
	@ObservedObject private var torrentTrackersPageViewModel: TorrentTrackersPageViewModel
	
	private var workItems: [DispatchWorkItem] = []
	private var cancellables = Set<AnyCancellable>()
	
	func showTorrentTrackers(_ id: Int) -> TorrentTrackersPage {
		self.id = id
		return TorrentTrackersPage(viewModel: torrentTrackersPageViewModel)
	}
	
	func stopLoadingData() {
		cancelCurrentLoadingTasks()
	}
	
	func loadData() {
		cancelCurrentLoadingTasks()
		guard let server = UserDefaultsHandler.shared.currentServer else {
			return
		}
		TransmissionHTTPClient.makeTorrentTrackersLoader(id: id, server: server)
			.dispatchOnMainQueue()
			.sink(
				receiveCompletion: { [weak self] completion in
					switch completion {
					case .finished: break
					case .failure(let error):
						self?.torrentTrackersPageViewModel.newValues(.error(error.localizedDescription))
					}
				},
				receiveValue: { [weak self] torrentTrackers in
					let viewModel = TorrentTrackersPagePresenter.map(torrentTrackers)
					self?.torrentTrackersPageViewModel.newValues(viewModel)
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

private extension TorrentTrackersPageViewModel {
	func newValues(_ viewModel: TorrentTrackersPageViewModel) {
		trackers = viewModel.trackers
		errorMessage = viewModel.errorMessage
	}
}

