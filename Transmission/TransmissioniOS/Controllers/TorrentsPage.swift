//
//  TorrentsPage.swift
//  TransmissioniOS
//
//  Created by Federico Arvat on 18/07/23.
//

import SwiftUI
import Transmission
import UniformTypeIdentifiers

public struct TorrentsPage: View {
	
	public init(viewModel: TorrentsPageViewModel) {
		self.viewModel = viewModel
	}
	
	@ObservedObject var viewModel: TorrentsPageViewModel
	
	@State private var alertPresented: Bool = false
	
	@State private var linkAlertPresented: Bool = false
	
	@State private var fileImporterPresented: Bool = false
	
	@State private var torrentTypeDialogPresented: Bool = false
	
	@State private var torrentRemoveAlertPresented: Bool = false
	
	@State private var torrentRemoveAllAlertPresented: Bool = false
	
	@State private var deletingTorrentId: Int = -1
	
	@State private var link: String = ""
	
	public var stop: ((Int) -> Void)?
	
	public var stopAll: (() -> Void)?
	
	public var start: ((Int) -> Void)?
	
	public var startAll: (() -> Void)?
	
	public var loadData: (() -> Void)?
	
	public var selectedFile: ((URL) -> Void)?
	
	public var selectedLink: ((String) -> Void)?
	
	public var setDownloadLimit: ((Bool) -> Void)?
	
	public var deleteAll: ((_ deleteLocalData: Bool) -> Void)?
	
	public var delete: ((_ id: Int, _ deleteLocalData: Bool) -> Void)?
	
    public var body: some View {
		NavigationStack {
			VStack {
				if let error = viewModel.error {
					HStack {
						Spacer()
						Text(error)
							.font(.subheadline)
							.foregroundColor(Color.white)
							.padding()
							.multilineTextAlignment(.center)
						Spacer()
					}.background { Color.red }
				}
				if let message = viewModel.emptyMessage {
					HStack {
						Spacer()
						Text(message)
							.font(.subheadline)
							.padding()
							.multilineTextAlignment(.center)
						Spacer()
					}
				} else {
					if viewModel.isLoading, viewModel.error == nil {
						VStack {
							ProgressView().progressViewStyle(.circular)
						}
					} else {
						List {
							ForEach(viewModel.torrents) { torrent in
								VStack(alignment: .leading) {
									Text(torrent.name)
										.font(.subheadline)
									Text(torrent.downloaded)
										.font(.caption2)
									HStack {
										ProgressView(value: torrent.completionPercentage)
											.tint(progressBarColor(torrent))
										Text(torrent.completionPercentageString)
											.font(.caption2)
									}
									HStack {
										Text(torrent.error ?? torrent.description)
											.font(.caption2)
											.foregroundColor(torrent.error == nil ? .primary : .red)
											.contextMenu {
												Button(role: .destructive) {
													deletingTorrentId = torrent.id
													torrentRemoveAlertPresented.toggle()
												} label: {
													Text(TorrentsPagePresenter.remove)
												}
												switch torrent.status {
												case .running, .completed:
													Button {
														stop?(torrent.id)
													} label: {
														Text(TorrentsPagePresenter.stop)
													}
												case .stopped:
													Button {
														start?(torrent.id)
													} label: {
														Text(TorrentsPagePresenter.start)
													}
												}
											}
										Spacer()
										VStack(alignment: .trailing, spacing: 4) {
											HStack(spacing: 2) {
												Text(torrent.uploadSpeed)
													.font(.caption2)
												Image(systemName: "arrow.up")
													.resizable()
													.scaledToFit()
													.foregroundColor(.red)
													.frame(width: 8, height: 8)
											}
											HStack(spacing: 2) {
												Text(torrent.downloadSpeed)
													.font(.caption2)
												Image(systemName: "arrow.down")
													.resizable()
													.scaledToFit()
													.foregroundColor(.green)
													.frame(width: 8, height: 8)
											}
										}
									}
								}
							}
						}.listStyle(.insetGrouped)
					}
				}
			}
			.navigationTitle(viewModel.title)
			.navigationBarTitleDisplayMode(.inline)
			.toolbar {
				if viewModel.canAddTorrent {
					ToolbarItemGroup(placement: .navigationBarTrailing) {
						Menu {
							Button {
								setDownloadLimit?(!viewModel.temporarySpeedEnabled)
							} label: {
								if viewModel.temporarySpeedEnabled {
									Text(TorrentsPagePresenter.unlockSpeedLimit)
									Image(systemName: "lock.open.fill")
								} else {
									Text("\(TorrentsPagePresenter.lockTo) \(viewModel.temporaryUploadSpeed) \(TorrentsPagePresenter.up), \(viewModel.temporaryDownloadSpeed) \(TorrentsPagePresenter.down)")
									Image(systemName: "lock.fill")
								}
							}
							Button {
								stopAll?()
							} label: {
								Text(TorrentsPagePresenter.stopAll)
								Image(systemName: "stop.fill")
							}
							Button {
								startAll?()
							} label: {
								Text(TorrentsPagePresenter.startAll)
								Image(systemName: "play.fill")
							}
							Button(role: .destructive) {
								torrentRemoveAllAlertPresented.toggle()
							} label: {
								Text(TorrentsPagePresenter.removeAll)
								Image(systemName: "xmark")
							}
						} label: {
							Image(systemName: "ellipsis.circle")
								.foregroundColor(.primary)
						}
						Button {
							torrentTypeDialogPresented.toggle()
						} label: {
							Image(systemName: "plus")
								.foregroundColor(.primary)
						}
					}
				}
				ToolbarItemGroup(placement: .navigationBarLeading) {
					if viewModel.temporarySpeedEnabled {
						Image(assetName: "turtle")
							.renderingMode(.template)
							.resizable()
							.frame(width: 30, height: 30)
					}
				}
				ToolbarItemGroup(placement: .bottomBar) {
					Image(systemName: "arrow.up")
						.resizable()
						.scaledToFit()
						.foregroundColor(.red)
						.frame(width: 16, height: 16)
						.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 4))
					Text(viewModel.uploadSpeed)
						.font(.subheadline)
					Spacer()
					Text(viewModel.freeDiskSpace)
						.font(.caption)
					Spacer()
					Image(systemName: "arrow.down")
						.resizable()
						.scaledToFit()
						.foregroundColor(.green)
						.frame(width: 16, height: 16)
						.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 4))
					Text(viewModel.downloadSpeed)
						.font(.subheadline)
				}
			}
			.fileImporter(
				isPresented: $fileImporterPresented,
				allowedContentTypes: [.item],
				onCompletion: { result in
					switch result {
					case .failure(let error):
						// TODO: show error message
						print(error)
					case let .success(url):
						selectedFile?(url)
					}
				}
			)
			.confirmationDialog("",
				isPresented: $torrentTypeDialogPresented,
				actions: {
					Button {
						fileImporterPresented.toggle()
					} label: {
						Text(TorrentsPagePresenter.torrent)
					}
					Button {
						linkAlertPresented.toggle()
					} label: {
						Text(TorrentsPagePresenter.link)
					}
				}
			)
			.alert(
				TorrentsPagePresenter.linkTitle,
				isPresented: $linkAlertPresented,
				actions: {
					TextField(TorrentsPagePresenter.linkPlaceholder, text: $link)
					Button(action: {
						selectedLink?(link)
						link = ""
					}, label: {
						Text(TorrentsPagePresenter.ok)
					})
					Button(role: .cancel, action: {
						link = ""
					}, label: {
						Text(TorrentsPagePresenter.cancel)
					})
					
				},
				message: {
					Text(TorrentsPagePresenter.linkInsertDescription)
				}
			)
			.alert(
				TorrentsPagePresenter.alertErrorTitle,
				isPresented: $viewModel.alertMessageVisible,
				actions: {
					Button(action: {
						viewModel.alertMessage = nil
					}, label: {
						Text(TorrentsPagePresenter.ok)
					})
				},
				message: {
					Text(viewModel.alertMessage ?? "")
				}
			)
			.alert(
				TorrentsPagePresenter.deleteTorrentAlertTitle,
				isPresented: $torrentRemoveAlertPresented,
				actions: {
					Button {
						delete?(deletingTorrentId, false)
						deletingTorrentId = -1
					} label: {
						Text(TorrentsPagePresenter.keepLocalData)
					}
					Button(role: .destructive) {
						delete?(deletingTorrentId, true)
						deletingTorrentId = -1
					} label: {
						Text(TorrentsPagePresenter.deleteLocalData)
					}
					Button(role: .cancel) {
						deletingTorrentId = -1
					} label: {
						Text(TorrentsPagePresenter.cancel)
					}
				},
				message: {
					Text(TorrentsPagePresenter.deleteTorrentAlertMessage)
				}
			)
			.alert(
				TorrentsPagePresenter.deleteTorrentAlertTitle,
				isPresented: $torrentRemoveAllAlertPresented,
				actions: {
					Button {
						deleteAll?(false)
					} label: {
						Text(TorrentsPagePresenter.keepLocalData)
					}
					Button(role: .destructive) {
						deleteAll?(true)
					} label: {
						Text(TorrentsPagePresenter.deleteLocalData)
					}
					Button(role: .cancel) {} label: {
						Text(TorrentsPagePresenter.cancel)
					}
				},
				message: {
					Text(TorrentsPagePresenter.deleteAllTorrentAlertMessage)
				}
			)
		}
		.onLoad {
			loadData?()
		}
		.if(viewModel.error != nil) { navigationStack in
			navigationStack.refreshable {
				loadData?()
			}
		}
	}
	
	private func progressBarColor(_ torrent: TorrentViewModel) -> Color {
		guard torrent.error == nil else { return .red }
		switch torrent.status {
		case .completed: return .green
		case .running: return .blue
		case .stopped: return .gray
		}
	}
}

struct TorrentsPage_Previews: PreviewProvider {
    static var previews: some View {
		TorrentsPage(
			viewModel: TorrentsPageViewModel(
				title: "Title",
				isLoading: false,
				error: nil,
				uploadSpeed: "5,5 Mb/s",
				downloadSpeed: "5,5 Mb/s",
				temporaryUploadSpeed: "50 Kb/s",
				temporaryDownloadSpeed: "50 Kb/s",
				temporarySpeedEnabled: true,
				torrents: [
					TorrentViewModel(
						id: 1,
						name: "a name",
						error: "download error",
						description: "-",
						completionPercentage: 0.5,
						completionPercentageString: "50%",
						downloaded: "5,4GB of 7,8GB",
						uploadSpeed: "450,00 KB/s",
						downloadSpeed: "450,00 KB/s",
						status: .running
					),
					TorrentViewModel(
						id: 2,
						name: "another name",
						description: "Seeding",
						completionPercentage: 1,
						completionPercentageString: "100%",
						downloaded: "5,4GB of 7,8GB",
						uploadSpeed: "5,60 MB/s",
						downloadSpeed: "5,60 MB/s",
						status: .completed
					)
				],
				freeDiskSpace: "Free space 256,0 GB",
				emptyMessage: nil,
				canAddTorrent: true,
				alertMessage: nil,
				alertMessageVisible: false
			)
		)
    }
}
