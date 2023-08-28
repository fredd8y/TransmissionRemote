//
//  PeersSettingsPage.swift
//  TransmissioniOS
//
//  Created by Federico Arvat on 28/08/23.
//

import SwiftUI
import Transmission

public struct PeersSettingsPage: View {
	
	public init(viewModel: PeersSettingsPageViewModel) {
		self.viewModel = viewModel
	}
	
	@FocusState private var peerLimitGlobalFocused: Bool
	
	@FocusState private var peerLimitPerTorrentFocused: Bool
	
	@FocusState private var blocklistUrlFocused: Bool
	
	@Environment(\.isPresented) var isPresented
	
	@State private var tabBarVisibility: Visibility = .visible
	
	@ObservedObject private var viewModel: PeersSettingsPageViewModel
	
	public var onAppear: (() -> Void)?
	
	public var onRefresh: (() -> Void)?
	
	public var onDisappear: (() -> Void)?
	
	public var encryptionDescription: ((PeersSettingsPageViewModel.Encryption) -> String)?
	
	public var onEncryptionChange: ((PeersSettingsPageViewModel.Encryption) -> Void)?
	
	public var onPexEnabledChange: ((Bool) -> Void)?
	
	public var onDhtEnabledChange: ((Bool) -> Void)?
	
	public var onLpdEnabledChange: ((Bool) -> Void)?
	
	public var onBlocklistEnabledChange: ((Bool) -> Void)?
	
	public var onUpdateTapped: ((String) -> Void)?
	
	public var onPeerLimitGlobalChange: ((String) -> Void)?
	
	public var onPeerLimitPerTorrentChange: ((String) -> Void)?
	
	public var onBlocklistUrlChange: ((String) -> Void)?
	
	public var body: some View {
		VStack {
			if viewModel.isLoading {
				ProgressView()
			} else {
				if let errorMessage = viewModel.errorMessage {
					HStack {
						Spacer()
						Text(errorMessage)
							.font(.subheadline)
							.foregroundColor(Color.white)
							.padding()
							.multilineTextAlignment(.center)
						Spacer()
					}.background { Color.red }
					Spacer()
				} else {
					List {
						Section(PeersSettingsPagePresenter.connections) {
							VStack(alignment: .leading, spacing: 8) {
								Text(PeersSettingsPagePresenter.maxPeersPerTorrent)
									.font(.subheadline)
								TextField(PeersSettingsPagePresenter.maxPeersPerTorrent, text: $viewModel.peerLimitPerTorrent)
									.textFieldStyle(.roundedBorder)
									.keyboardType(.numberPad)
									.focused($peerLimitPerTorrentFocused)
								if viewModel.peerLimitPerTorrentError {
									Text(PeersSettingsPagePresenter.mustBeANumber)
										.font(.caption2)
										.foregroundColor(.red)
								}
							}
							VStack(alignment: .leading, spacing: 8) {
								Text(PeersSettingsPagePresenter.maxPeersOverall)
									.font(.subheadline)
								TextField(PeersSettingsPagePresenter.maxPeersOverall, text: $viewModel.peerLimitGlobal)
									.textFieldStyle(.roundedBorder)
									.keyboardType(.numberPad)
									.focused($peerLimitGlobalFocused)
								if viewModel.peerLimitGlobalError {
									Text(PeersSettingsPagePresenter.mustBeANumber)
										.font(.caption2)
										.foregroundColor(.red)
								}
							}
						}
						Section(PeersSettingsPagePresenter.options) {
							Picker(PeersSettingsPagePresenter.encryptionMode, selection: $viewModel.encryption) {
								ForEach(PeersSettingsPageViewModel.Encryption.allCases, id: \.self) {
									Text(encryptionDescription?($0) ?? "-")
								}
							}
							.font(.subheadline)
							.onChange(of: viewModel.encryption) { newValue in
								onEncryptionChange?(newValue)
							}
							Toggle(isOn: $viewModel.pexEnabled) {
								Text(PeersSettingsPagePresenter.pexDescription)
							}.onChange(of: viewModel.pexEnabled) { newValue in
								onPexEnabledChange?(newValue)
							}
							Toggle(isOn: $viewModel.dhtEnabled) {
								Text(PeersSettingsPagePresenter.dhtDescription)
							}.onChange(of: viewModel.dhtEnabled) { newValue in
								onDhtEnabledChange?(newValue)
							}
							Toggle(isOn: $viewModel.lpdEnabled) {
								Text(PeersSettingsPagePresenter.lpdDescription)
							}.onChange(of: viewModel.lpdEnabled) { newValue in
								onLpdEnabledChange?(newValue)
							}
						}
						Section(PeersSettingsPagePresenter.blocklist) {
							VStack(alignment: .leading) {
								Toggle(isOn: $viewModel.blocklistEnabled) {
									Text(PeersSettingsPagePresenter.enableBlocklist)
								}.onChange(of: viewModel.blocklistEnabled) { newValue in
									onBlocklistEnabledChange?(newValue)
								}
								TextField(PeersSettingsPagePresenter.maxPeersOverall, text: $viewModel.blocklistUrl)
									.textFieldStyle(.roundedBorder)
									.keyboardType(.numberPad)
									.focused($blocklistUrlFocused)
									.disabled(!viewModel.blocklistEnabled)
								if viewModel.blocklistUrlError {
									Text(PeersSettingsPagePresenter.mustBeAnUrl)
										.font(.caption2)
										.foregroundColor(.red)
								}
							}
							VStack(alignment: .leading) {
								Text(viewModel.blocklistSize)
								Button {
									onUpdateTapped?(viewModel.blocklistUrl)
								} label: {
									Text(PeersSettingsPagePresenter.update)
								}
								.buttonStyle(.bordered)
								.foregroundColor(.primary)
								.disabled(!viewModel.blocklistEnabled)
							}
						}
					}
					.listStyle(.insetGrouped)
					.toolbar {
						ToolbarItemGroup(placement: .keyboard) {
							Spacer()
							Button(PeersSettingsPagePresenter.confirm) {
								if peerLimitGlobalFocused {
									peerLimitGlobalFocused.toggle()
									onPeerLimitGlobalChange?(viewModel.peerLimitGlobal)
								} else if peerLimitPerTorrentFocused {
									peerLimitPerTorrentFocused.toggle()
									onPeerLimitPerTorrentChange?(viewModel.peerLimitPerTorrent)
								} else if blocklistUrlFocused {
									blocklistUrlFocused.toggle()
									onBlocklistUrlChange?(viewModel.blocklistUrl)
								}
							}
						}
					}
				}
			}
		}
		.navigationTitle(PeersSettingsPagePresenter.title)
		.navigationBarTitleDisplayMode(.inline)
		.toolbar(tabBarVisibility, for: .tabBar)
		.alert(
			"Error",
			isPresented: $viewModel.alertMessageVisible,
			actions: {
				Button(action: {
					viewModel.alertMessage = nil
				}, label: {
					Text("Ok")
				})
			},
			message: {
				Text(viewModel.alertMessage ?? "")
			}
		)
		.onAppear {
			onAppear?()
		}
		.onDisappear {
			onDisappear?()
		}
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
		.if(viewModel.errorMessage != nil) { vStack in
			vStack.refreshable {
				onRefresh?()
			}
		}
	}
}

struct PeersSettingsPage_Previews: PreviewProvider {
    static var previews: some View {
		PeersSettingsPage(viewModel: PeersSettingsPageViewModel(
			alertMessage: nil,
			alertMessageVisible: false,
			errorMessage: nil,
			isLoading: false,
			peerLimitGlobal: "500",
			peerLimitGlobalError: false,
			peerLimitPerTorrent: "60",
			peerLimitPerTorrentError: false,
			pexEnabled: true,
			dhtEnabled: true,
			lpdEnabled: true,
			blocklistEnabled: false,
			blocklistSize: "32422",
			blocklistUrl: "an url",
			blocklistUrlError: false,
			encryption: .tolerated
		))
    }
}
