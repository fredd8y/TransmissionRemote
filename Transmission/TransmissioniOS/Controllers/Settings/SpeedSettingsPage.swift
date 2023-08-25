//
//  SpeedSettingsPage.swift
//  TransmissioniOS
//
//  Created by Federico Arvat on 25/08/23.
//

import SwiftUI
import Transmission

public struct SpeedSettingsPage: View {
	
	public init(viewModel: SpeedSettingsPageViewModel) {
		self.viewModel = viewModel
	}
	
	@FocusState private var uploadLimitFocused: Bool
	
	@FocusState private var downloadLimitFocused: Bool
	
	@FocusState private var alternativeUploadLimitFocused: Bool
	
	@FocusState private var alternativeDownloadLimitFocused: Bool
		
	@ObservedObject private var viewModel: SpeedSettingsPageViewModel
	
	public var onAppear: (() -> Void)?
	
	public var onRefresh: (() -> Void)?
	
	public var onDisappear: (() -> Void)?
	
	public var onUploadLimitEnabledChange: ((Bool) -> Void)?
	
	public var onDownloadLimitEnabledChange: ((Bool) -> Void)?
	
	public var onScheduledTimesEnabledChange: ((Bool) -> Void)?
	
	public var onUploadLimit: ((String) -> Void)?
	
	public var onDownloadLimit: ((String) -> Void)?
	
	public var onAlternativeUploadLimit: ((String) -> Void)?
	
	public var onAlternativeDownloadLimit: ((String) -> Void)?
		
//	@State private var fromSelection: Int = 0
//	
//	@State private var toSelection: Int = 0
//	
//	@State private var onDaysSelection: Int = 0
	
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
						Section("Speed limits") {
							Toggle(isOn: $viewModel.uploadLimitEnabled) {
								VStack(alignment: .leading, spacing: 8) {
									Text("Upload (KB/s)")
										.font(.subheadline)
									TextField("Upload (KB/s)", text: $viewModel.uploadLimit)
										.textFieldStyle(.roundedBorder)
										.keyboardType(.numberPad)
										.disabled(!viewModel.uploadLimitEnabled)
										.focused($uploadLimitFocused)
									if viewModel.uploadLimitError {
										Text("Must be a number")
											.font(.caption2)
											.foregroundColor(.red)
									}
								}
							}.onChange(of: viewModel.uploadLimitEnabled) { newValue in
								onUploadLimitEnabledChange?(newValue)
							}
							Toggle(isOn: $viewModel.downloadLimitEnabled) {
								VStack(alignment: .leading, spacing: 8) {
									Text("Download (KB/s)")
										.font(.subheadline)
									TextField("Download (KB/s)", text: $viewModel.downloadLimit)
										.textFieldStyle(.roundedBorder)
										.keyboardType(.numberPad)
										.disabled(!viewModel.downloadLimitEnabled)
										.focused($downloadLimitFocused)
									if viewModel.downloadLimitError {
										Text("Must be a number")
											.font(.caption2)
											.foregroundColor(.red)
									}
								}
							}.onChange(of: viewModel.downloadLimitEnabled) { newValue in
								onDownloadLimitEnabledChange?(newValue)
							}
						}
						Section("Alternative speed limits") {
							Text("Override normal speed limits manually or at a scheduled times")
								.font(.caption)
							VStack(alignment: .leading, spacing: 8) {
								Text("Upload (KB/s)")
									.font(.subheadline)
								TextField("Upload (KB/s)", text: $viewModel.alternativeUploadLimit)
									.textFieldStyle(.roundedBorder)
									.keyboardType(.numberPad)
									.focused($alternativeUploadLimitFocused)
								if viewModel.alternativeUploadLimitError {
									Text("Must be a number")
										.font(.caption2)
										.foregroundColor(.red)
								}
							}
							VStack(alignment: .leading, spacing: 8) {
								Text("Download (KB/s)")
									.font(.subheadline)
								TextField("Download (KB/s)", text: $viewModel.alternativeDownloadLimit)
									.textFieldStyle(.roundedBorder)
									.keyboardType(.numberPad)
									.focused($alternativeDownloadLimitFocused)
								if viewModel.alternativeDownloadLimitError {
									Text("Must be a number")
										.font(.caption2)
										.foregroundColor(.red)
								}
							}
//							VStack(alignment: .leading) {
//								Toggle(isOn: $viewModel.scheduledTimesEnabled) {
//									Text("Scheduled times")
//								}.onChange(of: viewModel.downloadLimitEnabled) { newValue in
//									onScheduledTimesEnabledChange?(newValue)
//								}
//								VStack(alignment: .leading, spacing: 8) {
//									Picker("From", selection: $fromSelection) {
//										ForEach(0..<10) {
//											Text($0.description)
//										}
//									}
//									.font(.subheadline)
//									.disabled(!viewModel.scheduledTimesEnabled)
//									Picker("To", selection: $toSelection) {
//										ForEach(0..<10) {
//											Text($0.description)
//										}
//									}
//									.font(.subheadline)
//									.disabled(!viewModel.scheduledTimesEnabled)
//									Picker("On days", selection: $onDaysSelection) {
//										ForEach(0..<10) {
//											Text($0.description)
//										}
//									}
//									.font(.subheadline)
//									.disabled(!viewModel.scheduledTimesEnabled)
//								}
//							}
						}
					}
					.listStyle(.insetGrouped)
					.toolbar {
						ToolbarItemGroup(placement: .keyboard) {
							Spacer()
							Button("Confirm") {
								if uploadLimitFocused {
									uploadLimitFocused.toggle()
									onUploadLimit?(viewModel.uploadLimit)
								} else if downloadLimitFocused {
									downloadLimitFocused.toggle()
									onDownloadLimit?(viewModel.downloadLimit)
								} else if alternativeUploadLimitFocused {
									alternativeUploadLimitFocused.toggle()
									onAlternativeUploadLimit?(viewModel.alternativeUploadLimit)
								} else if alternativeDownloadLimitFocused {
									alternativeDownloadLimitFocused.toggle()
									onAlternativeDownloadLimit?(viewModel.alternativeDownloadLimit)
								}
							}
						}
					}
				}
			}
		}
		.navigationTitle(SpeedSettingsPagePresenter.title)
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

struct SpeedSettingsPage_Previews: PreviewProvider {
    static var previews: some View {
        SpeedSettingsPage(viewModel: SpeedSettingsPageViewModel(
			isLoading: false,
			errorMessage: nil,
			uploadLimitEnabled: false,
			uploadLimit: "100",
			uploadLimitError: false,
			downloadLimitEnabled: false,
			downloadLimit: "100",
			downloadLimitError: false,
			alternativeUploadLimit: "100",
			alternativeUploadLimitError: false,
			alternativeDownloadLimit: "100",
			alternativeDownloadLimitError: false,
			scheduledTimesEnabled: false,
			alternativeSpeedTimeBegin: "100",
			alternativeSpeedTimeDay: "100",
        	alternativeSpeedTimeEnd: "100"
        ))
	}
}
