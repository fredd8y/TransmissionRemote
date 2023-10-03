//
//  TorrentDetailTabContainer.swift
//  TransmissioniOS
//
//  Created by Federico Arvat on 18/08/23.
//

import SwiftUI
import Transmission

public struct TorrentDetailTabContainer: View {
	public init(torrentDetailPage: TorrentDetailPage, torrentPeersPage: TorrentPeersPage, torrentTrackersPage: TorrentTrackersPage) {
		self.torrentDetailPage = torrentDetailPage
		self.torrentPeersPage = torrentPeersPage
		self.torrentTrackersPage = torrentTrackersPage
		UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(assetName: "pageControlCurrentPageIndicatorTintColor")
		UIPageControl.appearance().pageIndicatorTintColor = UIColor(assetName: "pageControlPageIndicatorTintColor")
	}
	
	private var torrentDetailPage: TorrentDetailPage
	private var torrentPeersPage: TorrentPeersPage
	private var torrentTrackersPage: TorrentTrackersPage
		
	@Environment(\.dismiss) var dismiss
			
	@State var selectedTab = 0
	
	public var body: some View {
		NavigationStack {
			TabView(selection: $selectedTab) {
				torrentDetailPage.tag(0)
				torrentPeersPage.tag(1)
				torrentTrackersPage.tag(2)
			}
			.background(Color(uiColor: .systemGroupedBackground))
			.tabViewStyle(.page)
			.toolbar {
				ToolbarItemGroup(placement: .navigationBarLeading) {
					Button {
						dismiss()
					} label: {
						Text(TorrentsPagePresenter.closeTorrentDetail)
					}
				}
			}
		}
	}
}
