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
						Text("Last announce")
							.font(.subheadline)
						Spacer()
						Text(tracker.lastAnnounceTime)
							.font(.subheadline)
					}
					HStack {
						Text("Next announce")
							.font(.subheadline)
						Spacer()
						Text(tracker.nextAnnounceTime)
							.font(.subheadline)
					}
					HStack {
						Text("Last scrape")
							.font(.subheadline)
						Spacer()
						Text(tracker.lastScrapeTime)
							.font(.subheadline)
					}
					HStack {
						Text("Seeders")
							.font(.subheadline)
						Spacer()
						Text(tracker.seederCount)
							.font(.subheadline)
					}
					HStack {
						Text("Leechers")
							.font(.subheadline)
						Spacer()
						Text(tracker.leecherCount)
							.font(.subheadline)
					}
					HStack {
						Text("Downloads")
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
