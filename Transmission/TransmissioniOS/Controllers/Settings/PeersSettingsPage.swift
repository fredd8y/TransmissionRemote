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
	
	public var onUpdateTapped: (() -> Void)?
	
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
						Section("Connections") {
							VStack(alignment: .leading, spacing: 8) {
								Text("Max peers per torrent")
									.font(.subheadline)
								TextField("Max peers per torrent", text: $viewModel.peerLimitPerTorrent)
									.textFieldStyle(.roundedBorder)
									.keyboardType(.numberPad)
									.focused($peerLimitPerTorrentFocused)
								if viewModel.peerLimitPerTorrentError {
									Text("Must be a number")
										.font(.caption2)
										.foregroundColor(.red)
								}
							}
							VStack(alignment: .leading, spacing: 8) {
								Text("Max peers overall")
									.font(.subheadline)
								TextField("Max peers overall", text: $viewModel.peerLimitGlobal)
									.textFieldStyle(.roundedBorder)
									.keyboardType(.numberPad)
									.focused($peerLimitGlobalFocused)
								if viewModel.peerLimitGlobalError {
									Text("Must be a number")
										.font(.caption2)
										.foregroundColor(.red)
								}
							}
						}
						Section("Options") {
							Picker("Encryption mode", selection: $viewModel.encryption) {
								ForEach(PeersSettingsPageViewModel.Encryption.allCases, id: \.self) {
									Text(encryptionDescription?($0) ?? "-")
								}
							}
							.font(.subheadline)
							.onChange(of: viewModel.encryption) { newValue in
								onEncryptionChange?(newValue)
							}
							Toggle(isOn: $viewModel.pexEnabled) {
								Text("Use PEX to find more peers")
							}.onChange(of: viewModel.pexEnabled) { newValue in
								onPexEnabledChange?(newValue)
							}
							Toggle(isOn: $viewModel.dhtEnabled) {
								Text("Use DHT to find more peers")
							}.onChange(of: viewModel.dhtEnabled) { newValue in
								onDhtEnabledChange?(newValue)
							}
							Toggle(isOn: $viewModel.lpdEnabled) {
								Text("Use LPD to find more peers")
							}.onChange(of: viewModel.lpdEnabled) { newValue in
								onLpdEnabledChange?(newValue)
							}
						}
						Section("Blocklist") {
							VStack(alignment: .leading) {
								Toggle(isOn: $viewModel.blocklistEnabled) {
									Text("Enable blocklist")
								}.onChange(of: viewModel.blocklistEnabled) { newValue in
									onBlocklistEnabledChange?(newValue)
								}
								TextField("Max peers overall", text: $viewModel.blocklistUrl)
									.textFieldStyle(.roundedBorder)
									.keyboardType(.numberPad)
									.focused($blocklistUrlFocused)
								if viewModel.blocklistUrlError {
									Text("Must be an url")
										.font(.caption2)
										.foregroundColor(.red)
								}
							}
							VStack(alignment: .leading) {
								Text(viewModel.blocklistSize)
								Button {
									onUpdateTapped?()
								} label: {
									Text("Update")
								}
								.buttonStyle(.bordered)
								.foregroundColor(.primary)
							}
						}
					}
					.listStyle(.insetGrouped)
					.toolbar {
						ToolbarItemGroup(placement: .keyboard) {
							Spacer()
							Button("Confirm") {
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
