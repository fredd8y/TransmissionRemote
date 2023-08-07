//
//  ContainerView.swift
//  TransmissioniOS
//
//  Created by Federico Arvat on 27/07/23.
//

import SwiftUI
import Transmission

public struct ContainerView: View {
	
	public init(torrentsPage: TorrentsPage, settingsPage: SettingsPage) {
		self.torrentsPage = torrentsPage
		self.settingsPage = settingsPage
	}
	
	private var torrentsPage: TorrentsPage
	private var settingsPage: SettingsPage
	
	@State var selectedTab = 0
	
    public var body: some View {
		NavigationView {
			TabView(selection: $selectedTab) {
				torrentsPage
					.tabItem {
						Label("TORRENT", systemImage: "square.and.arrow.down")
					}.tag(0)
				settingsPage
					.tabItem {
						Label("SETTINGS", systemImage: "gear")
					}.tag(1)
			}
		}
    }
}
