//
//  TorrentTrackersPage.swift
//  TransmissioniOS
//
//  Created by Federico Arvat on 21/08/23.
//

import SwiftUI
import Transmission

public struct TorrentTrackersPage: View {
	
	public init(viewModel: TorrentTrackersPageViewModel) {
		self.viewModel = viewModel
	}
	
	@ObservedObject var viewModel: TorrentTrackersPageViewModel
	
	public var onAppear: (() -> Void)?
	
	public var onDisappear: (() -> Void)?
	
	public  var body: some View {
		List {
			ForEach(viewModel.trackers, id: \.id) { tracker in
				Section(tracker.host) {
					HStack {
						Text(TorrentTrackersPagePresenter.lastAnnounce)
							.font(.subheadline)
						Spacer()
						Text(tracker.lastAnnounceTime)
							.font(.subheadline)
					}
					HStack {
						Text(TorrentTrackersPagePresenter.nextAnnounce)
							.font(.subheadline)
						Spacer()
						Text(tracker.nextAnnounceTime)
							.font(.subheadline)
					}
					HStack {
						Text(TorrentTrackersPagePresenter.lastScrape)
							.font(.subheadline)
						Spacer()
						Text(tracker.lastScrapeTime)
							.font(.subheadline)
					}
					HStack {
						Text(TorrentTrackersPagePresenter.seeders)
							.font(.subheadline)
						Spacer()
						Text(tracker.seederCount)
							.font(.subheadline)
					}
					HStack {
						Text(TorrentTrackersPagePresenter.leechers)
							.font(.subheadline)
						Spacer()
						Text(tracker.leecherCount)
							.font(.subheadline)
					}
					HStack {
						Text(TorrentTrackersPagePresenter.downloads)
							.font(.subheadline)
						Spacer()
						Text(tracker.downloadCount)
							.font(.subheadline)
					}
				}
			}
		}
		.navigationTitle(TorrentTrackersPagePresenter.title)
		.navigationBarTitleDisplayMode(.inline)
		.listStyle(.insetGrouped)
		.onAppear {
			onAppear?()
		}
		.onDisappear {
			onDisappear?()
		}
	}
}

struct TorrentTrackersPage_Previews: PreviewProvider {
	static var previews: some View {
		TorrentTrackersPage(
			viewModel: TorrentTrackersPageViewModel(
				trackers: [
					TorrentTrackersPageViewModel.Tracker(
						id: 1,
						host: "host",
						lastAnnounceTime: "1 hour ago",
						lastAnnouncePeerCount: "1 hour ago",
						nextAnnounceTime: "in 4 hours",
						lastScrapeTime: "1 hour ago",
						seederCount: "12",
						leecherCount: "32",
						downloadCount: "12345"
					)
				]
			)
		)
	}
}
