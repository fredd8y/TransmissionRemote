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
	
	public init(viewModel: SettingsViewModel) {
		self.viewModel = viewModel
	}
	
	public var loadData: (() -> Void)?
	
	public var updateIntervalSelected: ((_ selectedInterval: String, _ intervalList: [String]) -> Void)?
	
    public var body: some View {
		NavigationStack {
			List {
				VStack(alignment: .leading) {
					Text(viewModel.pollingRateTitle)
						.font(.subheadline)
					Picker(viewModel.pollingRateTitle, selection: $viewModel.currentSelectedPollingRate) {
						ForEach(viewModel.pollingRateList, id: \.self) { Text($0) }
					}
					.pickerStyle(.segmented)
					.onChange(of: viewModel.currentSelectedPollingRate) { newValue in
						updateIntervalSelected?(newValue, viewModel.pollingRateList)
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
			pollingRateTitle: "Update interval",
			pollingRateList: ["2 seconds", "5 seconds", "10 seconds", "30 seconds"],
			currentSelectedPollingRate: "5 seconds",
			serversTitle: "Server",
			currentServerName: "Raspberry"
		))
    }
}
