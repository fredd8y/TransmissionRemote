//
//  TorrentsSettingsPage.swift
//  TransmissioniOS
//
//  Created by Federico Arvat on 22/08/23.
//

import Combine
import SwiftUI
import Transmission

public struct TorrentsSettingsPage: View {
	
	public init(viewModel: TorrentsSettingsPageViewModel) {
		self.viewModel = viewModel
	}
	
	@FocusState private var downloadDirFocused: Bool
	
	@FocusState private var seedRatioLimitFocused: Bool
	
	@FocusState private var idleSeedingLimitFocused: Bool
	
	@ObservedObject private var viewModel: TorrentsSettingsPageViewModel
	
	public var onAppear: (() -> Void)?
	
	public var onRefresh: (() -> Void)?
	
	public var onDisappear: (() -> Void)?
	
	public var onDownloadDirChange: ((String) -> Void)?
	
	public var onStartAddedTorrentChange: ((Bool) -> Void)?
	
	public var onRenamePartialFilesChange: ((Bool) -> Void)?
	
	public var onSeedRatioLimitedChange: ((Bool) -> Void)?
	
	public var onSeedRatioLimitChange: ((String) -> Void)?
	
	public var onIdleSeedingLimitEnabledChange: ((Bool) -> Void)?
	
	public var onIdleSeedingLimitChange: ((String) -> Void)?
	
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
						Section(TorrentsSettingsPagePresenter.downloadingHeader) {
							VStack(alignment: .leading, spacing: 8) {
								Text(TorrentsSettingsPagePresenter.downloadTo)
									.font(.subheadline)
								TextField(TorrentsSettingsPagePresenter.downloadTo, text: $viewModel.downloadDir)
									.keyboardType(.URL)
									.textFieldStyle(.roundedBorder)
									.focused($downloadDirFocused)
								if viewModel.downloadDirError {
									Text(TorrentsSettingsPagePresenter.mustBeADirectory)
										.font(.caption2)
										.foregroundColor(.red)
								}
							}
							Toggle(isOn: $viewModel.startAddedTorrents) {
								Text(TorrentsSettingsPagePresenter.startWhenAdded)
									.font(.subheadline)
							}.onChange(of: viewModel.startAddedTorrents) { newValue in
								onStartAddedTorrentChange?(newValue)
							}
							Toggle(isOn: $viewModel.renamePartialFiles) {
								Text(TorrentsSettingsPagePresenter.incompleteFileNamesExtension)
									.font(.subheadline)
							}.onChange(of: viewModel.renamePartialFiles) { newValue in
								onRenamePartialFilesChange?(newValue)
							}
						}
						Section(TorrentsSettingsPagePresenter.seedingHeader) {
							Toggle(isOn: $viewModel.seedRatioLimited) {
								VStack(alignment: .leading, spacing: 8) {
									Text(TorrentsSettingsPagePresenter.stopSeedingAtRatio)
										.font(.subheadline)
									TextField(TorrentsSettingsPagePresenter.stopSeedingAtRatio, text: $viewModel.seedRatioLimit)
										.textFieldStyle(.roundedBorder)
										.keyboardType(.numberPad)
										.disabled(!viewModel.seedRatioLimited)
										.focused($seedRatioLimitFocused)
									if viewModel.seedRatioLimitError {
										Text(TorrentsSettingsPagePresenter.mustBeANumber)
											.font(.caption2)
											.foregroundColor(.red)
									}
								}
							}.onChange(of: viewModel.seedRatioLimited) { newValue in
								onSeedRatioLimitedChange?(newValue)
							}
							Toggle(isOn: $viewModel.idleSeedingLimitEnabled) {
								VStack(alignment: .leading, spacing: 8) {
									Text(TorrentsSettingsPagePresenter.stopSeedingIfIdle)
										.font(.subheadline)
									TextField(TorrentsSettingsPagePresenter.stopSeedingIfIdle, text: $viewModel.idleSeedingLimit)
										.textFieldStyle(.roundedBorder)
										.keyboardType(.numberPad)
										.disabled(!viewModel.idleSeedingLimitEnabled)
										.focused($idleSeedingLimitFocused)
									if viewModel.idleSeedingLimitError {
										Text(TorrentsSettingsPagePresenter.mustBeANumber)
											.font(.caption2)
											.foregroundColor(.red)
									}
								}
							}.onChange(of: viewModel.idleSeedingLimitEnabled) { newValue in
								onIdleSeedingLimitEnabledChange?(newValue)
							}
						}
					}
					.listStyle(.insetGrouped)
					.toolbar {
						ToolbarItemGroup(placement: .keyboard) {
							Spacer()
							Button(TorrentsSettingsPagePresenter.confirmButtonTitle) {
								if idleSeedingLimitFocused {
									idleSeedingLimitFocused.toggle()
									onIdleSeedingLimitChange?(viewModel.idleSeedingLimit)
								} else if seedRatioLimitFocused {
									seedRatioLimitFocused.toggle()
									onSeedRatioLimitChange?(viewModel.seedRatioLimit)
								} else if downloadDirFocused {
									downloadDirFocused.toggle()
									onDownloadDirChange?(viewModel.downloadDir)
								}
							}
						}
					}
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
			isLoading: false,
			seedRatioLimitError: false,
			idleSeedingLimitError: false,
			downloadDirError: true
		))
    }
}
