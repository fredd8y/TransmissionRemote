//
//  SettingsPage.swift
//  TransmissioniOS
//
//  Created by Federico Arvat on 27/07/23.
//

import SwiftUI
import Transmission

public struct SettingsPage: View {
	
	@ObservedObject var viewModel: SettingsViewModel
	
	@State private var selectedUpdateInterval: String
	
	public init(viewModel: SettingsViewModel) {
		self.viewModel = viewModel
		
		selectedUpdateInterval = viewModel.updateIntervalList[viewModel.currentSelectedIntervalIndex]
	}
	
	public var loadData: (() -> Void)?
	
    public var body: some View {
		NavigationStack {
			List {
				VStack(alignment: .leading) {
					Text(viewModel.updateIntervalTitle)
						.font(.subheadline)
					Picker(viewModel.updateIntervalTitle, selection: $selectedUpdateInterval) {
						ForEach(viewModel.updateIntervalList, id: \.self) { Text($0) }
					}
					.pickerStyle(.segmented)
					.onChange(of: selectedUpdateInterval) { newValue in
						if let index = viewModel.updateIntervalList.firstIndex(of: newValue) {
							viewModel.currentSelectedIntervalIndex = index
						}
					}
				}
				NavigationLink {
					// TODO
				} label: {
					VStack(alignment: .leading) {
						Text(viewModel.serversTitle)
							.font(.subheadline)
							.padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
						Text(viewModel.currentServerName)
							.font(.caption2)
					}
				}

			}
			.listStyle(.plain)
			.navigationTitle(viewModel.title)
			.navigationBarTitleDisplayMode(.inline)
		}.onAppear {
			loadData?()
		}
    }
}

struct SettingsPage_Previews: PreviewProvider {
    static var previews: some View {
        SettingsPage(viewModel: SettingsViewModel(
			title: "Settings",
			updateIntervalTitle: "Update interval",
			updateIntervalList: ["2 seconds", "5 seconds", "10 seconds", "30 seconds"],
			currentSelectedIntervalIndex: 0,
			serversTitle: "Server",
			currentServerName: "Raspberry"
		))
    }
}
