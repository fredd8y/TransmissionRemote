//
//  TorrentsSettingsPage.swift
//  TransmissioniOS
//
//  Created by Federico Arvat on 22/08/23.
//

import SwiftUI
import Transmission

public struct TorrentsSettingsPage: View {
	
	public init(viewModel: TorrentsSettingsPageViewModel) {
		self.viewModel = viewModel
	}
	
	@ObservedObject private var viewModel: TorrentsSettingsPageViewModel
	
	public var onAppear: (() -> Void)?
	
	public var onRefresh: (() -> Void)?
	
	public var onDisappear: (() -> Void)?
	
	public var onStartAddedTorrentChange: ((Bool) -> Void)?
	
	public var onRenamePartialFilesChange: ((Bool) -> Void)?
	
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
						Section("Downloading") {
							VStack(alignment: .leading, spacing: 8) {
								Text("Download to")
									.font(.caption2)
								TextField("Download to", text: $viewModel.downloadDir)
							}
							Toggle(isOn: $viewModel.startAddedTorrents) {
								Text("Start when added")
									.font(.subheadline)
							}
							Toggle(isOn: $viewModel.renamePartialFiles) {
								Text("Append \".part\" to incomplete files names")
									.font(.subheadline)
							}
						}
						Section("Seeding") {
							Toggle(isOn: $viewModel.seedRatioLimited) {
								VStack(alignment: .leading, spacing: 8) {
									Text("Stop seeding at ratio")
										.font(.subheadline)
									TextField("Ratio", text: $viewModel.seedRatioLimit)
										.textFieldStyle(.roundedBorder)
										.disabled(!viewModel.seedRatioLimited)
								}
							}
							Toggle(isOn: $viewModel.idleSeedingLimitEnabled) {
								VStack(alignment: .leading, spacing: 8) {
									Text("Stop seeding if idle for (min")
										.font(.subheadline)
									TextField("Ratio", text: $viewModel.idleSeedingLimit)
										.textFieldStyle(.roundedBorder)
										.disabled(!viewModel.idleSeedingLimitEnabled)
								}
							}
						}
					}.listStyle(.insetGrouped)
				}
			}
		}
		.navigationTitle(TorrentsSettingsPagePresenter.title)
		.navigationBarTitleDisplayMode(.inline)
		.onAppear {
			onAppear?()
		}
		.onDisappear {
			onDisappear?()
		}
		.onChange(of: viewModel.startAddedTorrents) { newValue in
			onStartAddedTorrentChange?(newValue)
		}
		.onChange(of: viewModel.renamePartialFiles) { newValue in
			onRenamePartialFilesChange?(newValue)
		}
		.if(viewModel.errorMessage != nil) { vStack in
			vStack.refreshable {
				onRefresh?()
			}
		}
    }
}

struct TorrentsSettingsPage_Previews: PreviewProvider {
    static var previews: some View {
		TorrentsSettingsPage(viewModel: TorrentsSettingsPageViewModel(
			downloadDir: "/download/dir",
			startAddedTorrents: true,
			renamePartialFiles: true,
			seedRatioLimited: true,
			seedRatioLimit: "2",
			idleSeedingLimitEnabled: true,
			idleSeedingLimit: "31",
			errorMessage: nil,
			isLoading: false
		))
    }
}
