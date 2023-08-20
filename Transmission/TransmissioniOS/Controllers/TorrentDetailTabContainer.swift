//
//  TorrentDetailTabContainer.swift
//  TransmissioniOS
//
//  Created by Federico Arvat on 18/08/23.
//

import SwiftUI

public struct TorrentDetailTabContainer: View {
	public init(torrentDetailPage: TorrentDetailPage, torrentPeersPage: TorrentPeersPage) {
		self.torrentDetailPage = torrentDetailPage
		self.torrentPeersPage = torrentPeersPage
	}
	
	private var torrentDetailPage: TorrentDetailPage
	private var torrentPeersPage: TorrentPeersPage
	
	@Environment(\.isPresented) var isPresented
	
	@State private var tabBarVisibility: Visibility = .visible
	
	@State var selectedTab = 0
	
	public var body: some View {
		TabView(selection: $selectedTab) {
			torrentDetailPage.tag(0)
			torrentPeersPage.tag(1)
		}
		.background(Color(uiColor: .systemGroupedBackground))
		.tabViewStyle(.page)
		.toolbar(tabBarVisibility, for: .tabBar)
		.onLoad {
			withAnimation {
				tabBarVisibility = .hidden
			}
		}
		.onChange(of: isPresented) { _ in
			withAnimation {
				tabBarVisibility = .visible
			}
		}
	}
}
