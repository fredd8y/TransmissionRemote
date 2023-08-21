//
//  TorrentDetailPagePresentationAdapter.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 17/08/23.
//

import Combine
import SwiftUI
import Transmission
import TransmissioniOS

final class TorrentDetailPagePresentationAdapter {
	
	init(torrentDetailPageViewModel: TorrentDetailPageViewModel) {
		self.torrentDetailPageViewModel = torrentDetailPageViewModel
	}
	
	private var id: Int!
	
	@ObservedObject private var torrentDetailPageViewModel: TorrentDetailPageViewModel
	
	private var workItems: [DispatchWorkItem] = []
	private var cancellables = Set<AnyCancellable>()
	
	func showTorrentDetail(_ id: Int) -> TorrentDetailPage {
		self.id = id
		return TorrentDetailPage(viewModel: torrentDetailPageViewModel)
	}
	
	func stopLoadingData() {
		cancelCurrentLoadingTasks()
	}
	
	func loadData() {
		cancelCurrentLoadingTasks()
		guard let server = UserDefaultsHandler.shared.currentServer else {
			return
		}
		TransmissionHTTPClient.makeTorrentDetailLoader(id: id, server: server)
			.dispatchOnMainQueue()
			.sink(
				receiveCompletion: { [weak self] completion in
					switch completion {
					case .finished: break
					case .failure(let error):
						self?.torrentDetailPageViewModel.newValues(.apiError(error.localizedDescription))
					}
				},
				receiveValue: { [weak self] torrentDetail in
					let viewModel = TorrentDetailPresenter.map(torrentDetail)
					self?.torrentDetailPageViewModel.newValues(viewModel)
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

private extension TorrentDetailPageViewModel {
	func newValues(_ viewModel: TorrentDetailPageViewModel) {
		name = viewModel.name
		errorMessage = viewModel.errorMessage
		percentageCompleted = viewModel.percentageCompleted
		uploaded = viewModel.uploaded
		ratio = viewModel.ratio
		downloaded = viewModel.downloaded
		state = viewModel.state
		runningTime = viewModel.runningTime
		remainingTime = viewModel.remainingTime
		lastActivity = viewModel.lastActivity
		error = viewModel.error
		size = viewModel.size
		location = viewModel.location
		hash = viewModel.hash
		privacy = viewModel.privacy
	}
}
