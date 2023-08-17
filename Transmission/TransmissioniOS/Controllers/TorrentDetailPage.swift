//
//  TorrentDetailPage.swift
//  TransmissioniOS
//
//  Created by Federico Arvat on 17/08/23.
//

import SwiftUI
import Transmission

public struct TorrentDetailPage: View {
	
	public init(viewModel: TorrentDetailViewModel) {
		self.viewModel = viewModel
	}
	
	@ObservedObject var viewModel: TorrentDetailViewModel
	
    public var body: some View {
		NavigationStack {
			List {
				Section(TorrentDetailPresenter.activitySectionHeader) {
					item(title: TorrentDetailPresenter.name, value: viewModel.name)
					item(title: TorrentDetailPresenter.percentageCompleted, value: viewModel.percentageCompleted)
					item(title: TorrentDetailPresenter.uploaded, value: viewModel.uploaded)
					item(title: TorrentDetailPresenter.downloaded, value: viewModel.downloaded)
					item(title: TorrentDetailPresenter.state, value: viewModel.state)
					item(title: TorrentDetailPresenter.runningTime, value: viewModel.runningTime)
					item(title: TorrentDetailPresenter.remainingTime, value: viewModel.remainingTime)
					item(title: TorrentDetailPresenter.lastActivity, value: viewModel.lastActivity)
					item(title: TorrentDetailPresenter.error, value: viewModel.error)
				}
				Section(TorrentDetailPresenter.detailsSectionHeader) {
					item(title: TorrentDetailPresenter.size, value: viewModel.size)
					item(title: TorrentDetailPresenter.location, value: viewModel.location)
					item(title: TorrentDetailPresenter.hash, value: viewModel.hash)
					item(title: TorrentDetailPresenter.privacy, value: viewModel.privacy)
				}
			}
			.navigationTitle(TorrentDetailPresenter.title)
			.navigationBarTitleDisplayMode(.inline)
		}
    }
	
	private func item(title: String, value: String) -> some View {
		VStack(alignment: .leading, spacing: 8) {
			Text(title)
				.font(.caption)
			Text(value)
				.font(.subheadline)
		}
	}
}

struct TorrentDetailPage_Previews: PreviewProvider {
    static var previews: some View {
		TorrentDetailPage(
			viewModel: TorrentDetailViewModel(
				name: "Torrent name",
				percentageCompleted: "56,98%",
				uploaded: "123,00 MB",
				ratio: "0,09",
				downloaded: "234,98 MB",
				state: "Downloading",
				runningTime: "24 hours",
				remainingTime: "2 hours",
				lastActivity: "12 hours ago",
				error: "None",
				size: "123,00 GB",
				location: "/here",
				hash: "ex2m190ixs9021ixs90m1i2s",
				privacy: "Public torrent"
			)
		)
	}
}
