//
//  SettingsPage.swift
//  TransmissioniOS
//
//  Created by Federico Arvat on 27/07/23.
//

import SwiftUI
import Transmission

public struct SettingsPage: View {
	
	@ObservedObject var viewModel: SettingsPageViewModel
		
	private var serverPage: ServerPage
	
	public init(viewModel: SettingsPageViewModel, serverPage: ServerPage) {
		self.viewModel = viewModel
		self.serverPage = serverPage
	}
	
	public var loadData: (() -> Void)?
	
	public var torrentsSettingsSelected: (() -> TorrentsSettingsPage)?
	
	public var speedSettingsSelected: (() -> SpeedSettingsPage)?
	
	public var peersSettingsSelected: (() -> PeersSettingsPage)?
	
	public var networkSettingsSelected: (() -> NetworkSettingsPage)?
	
	public var pollingRateSelected: ((_ selectedPollingRate: String, _ pollingRateList: [String]) -> Void)?
	
	@State public var torrentsSettingsPresented: Bool = false
	
    public var body: some View {
		NavigationStack {
			List {
				Section {
					VStack(alignment: .leading) {
						Text(viewModel.pollingRateTitle)
							.font(.subheadline)
						Picker(viewModel.pollingRateTitle, selection: $viewModel.currentSelectedPollingRate) {
							ForEach(viewModel.pollingRateList, id: \.self) { Text($0) }
						}
						.pickerStyle(.segmented)
						.onChange(of: viewModel.currentSelectedPollingRate) { newValue in
							pollingRateSelected?(newValue, viewModel.pollingRateList)
						}
					}
				}
				Section {
					NavigationLink {
						serverPage
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
				Section {
					NavigationLink {
						torrentsSettingsSelected?()
					} label: {
						Text(SettingsPagePresenter.torrentsSettings)
							.font(.subheadline)
					}
					NavigationLink {
						speedSettingsSelected?()
					} label: {
						Text(SettingsPagePresenter.speedSettings)
							.font(.subheadline)
					}
					NavigationLink {
						peersSettingsSelected?()
					} label: {
						Text(SettingsPagePresenter.peersSettings)
							.font(.subheadline)
					}
					NavigationLink {
						networkSettingsSelected?()
					} label: {
						Text(SettingsPagePresenter.networkSettings)
							.font(.subheadline)
					}
				}
				Section {
					NavigationLink {
						CreditsPage()
					} label: {
						Text(SettingsPagePresenter.credits)
							.font(.subheadline)
					}
				}
			}
			.listStyle(.insetGrouped)
			.navigationTitle(viewModel.title)
			.navigationBarTitleDisplayMode(.inline)
		}.onLoad {
			loadData?()
		}
    }
}

struct SettingsPage_Previews: PreviewProvider {
	static var previews: some View {
		SettingsPage(
			viewModel: SettingsPageViewModel(
				title: "Settings",
				pollingRateTitle: "Update interval",
				pollingRateList: ["2 seconds", "5 seconds", "10 seconds", "30 seconds"],
				currentSelectedPollingRate: "5 seconds",
				serversTitle: "Server",
				currentServerName: "Raspberry"
			),
			serverPage: ServerPage(
				viewModel: ServerPageViewModel(
					title: "Title",
					servers: [],
					editItemActionTitle: "Edit",
					deleteItemActionTitle: "Delete",
					currentSelectedServerId: nil,
					emptyMessage: "Test",
					alertMessage: nil,
					alertMessageVisible: false
				)
			)
		)
	}
}
