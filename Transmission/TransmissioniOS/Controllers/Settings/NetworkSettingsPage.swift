//
//  NetworkSettingsPage.swift
//  TransmissioniOS
//
//  Created by Federico Arvat on 29/08/23.
//

import Combine
import SwiftUI
import Transmission

public struct NetworkSettingsPage: View {
	
	public init(viewModel: NetworkSettingsPageViewModel) {
		self.viewModel = viewModel
	}
	
	@FocusState private var listeningPortFocused: Bool
	
	@Environment(\.isPresented) var isPresented
	
	@State private var tabBarVisibility: Visibility = .hidden
	
	@ObservedObject private var viewModel: NetworkSettingsPageViewModel
	
	public var onAppear: (() -> Void)?
	
	public var onRefresh: (() -> Void)?
	
	public var onDisappear: (() -> Void)?
	
	public var onPeerPortRandomOnStartChange: ((Bool) -> Void)?
	
	public var onPortForwardingEnabledChange: ((Bool) -> Void)?
	
	public var onUtpEnabledChange: ((Bool) -> Void)?
	
	public var onListeningPortChange: ((String) -> Void)?
	
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
						Section(NetworkSettingsPagePresenter.listeningPort) {
							VStack(alignment: .leading, spacing: 8) {
								Text(NetworkSettingsPagePresenter.peerListeningPort)
									.font(.subheadline)
								TextField(NetworkSettingsPagePresenter.peerListeningPort, text: $viewModel.peerPort)
									.textFieldStyle(.roundedBorder)
									.keyboardType(.numberPad)
									.focused($listeningPortFocused)
								if viewModel.peerPortError {
									Text(NetworkSettingsPagePresenter.mustBeANumberError)
										.font(.caption2)
										.foregroundColor(.red)
								}
								Text(viewModel.portStatus)
									.fontWeight(.bold)
									.font(.subheadline)
							}
							Toggle(isOn: $viewModel.peerPortRandomOnStart) {
								Text(NetworkSettingsPagePresenter.randomizePortOnLaunch)
							}.onChange(of: viewModel.peerPortRandomOnStart) { newValue in
								onPeerPortRandomOnStartChange?(newValue)
							}
							Toggle(isOn: $viewModel.portForwardingEnabled) {
								Text(NetworkSettingsPagePresenter.portForwardingFromRouter)
							}.onChange(of: viewModel.portForwardingEnabled) { newValue in
								onPortForwardingEnabledChange?(newValue)
							}
						}
						Section("Options") {
							Toggle(isOn: $viewModel.utpEnabled) {
								Text(NetworkSettingsPagePresenter.enableUtpForCommunication)
							}.onChange(of: viewModel.utpEnabled) { newValue in
								onUtpEnabledChange?(newValue)
							}
						}
					}
					.listStyle(.insetGrouped)
					.toolbar {
						ToolbarItemGroup(placement: .keyboard) {
							Spacer()
							Button(NetworkSettingsPagePresenter.confirm) {
								listeningPortFocused.toggle()
								onListeningPortChange?(viewModel.peerPort)
							}
						}
					}
				}
			}
		}
		.navigationTitle(NetworkSettingsPagePresenter.title)
		.navigationBarTitleDisplayMode(.inline)
		.toolbar(tabBarVisibility, for: .tabBar)
		.onAppear {
			onAppear?()
		}
		.onDisappear {
			onDisappear?()
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

struct NetworkSettingsPage_Previews: PreviewProvider {
	static var previews: some View {
		NetworkSettingsPage(viewModel: NetworkSettingsPageViewModel(
			errorMessage: nil,
			isLoading: false,
			peerPort: "51413",
			peerPortError: false,
			peerPortRandomOnStart: false,
			portForwardingEnabled: false,
			utpEnabled: true,
			portStatus: "Port closed"
		))
	}
}
