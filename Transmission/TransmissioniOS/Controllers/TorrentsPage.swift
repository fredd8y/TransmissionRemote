//
//  TorrentsPage.swift
//  TransmissioniOS
//
//  Created by Federico Arvat on 18/07/23.
//

import SwiftUI
import Transmission

public struct TorrentsPage: View {
	
	public init(viewModel: TorrentsPageViewModel) {
		self.viewModel = viewModel
	}
	
	@ObservedObject var viewModel: TorrentsPageViewModel
	
	public var loadData: (() -> Void)?
	
	public var authenticate: ((_ username: String, _ password: String) -> Void)? = nil
	
	@State private var username: String = ""
	@State private var password: String = ""
	
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
					List {
						ForEach(viewModel.torrents) { torrent in
							VStack(alignment: .leading) {
								Text(torrent.name)
									.font(.subheadline)
								Text(torrent.downloaded)
									.font(.caption2)
								HStack {
									ProgressView(value: torrent.completionPercentage)
										.tint(torrent.error == nil ? .blue : .red)
									Text(torrent.completionPercentageString)
										.font(.caption2)
								}
								Text(torrent.error ?? torrent.eta)
									.font(.caption2)
									.foregroundColor(torrent.error == nil ? .primary : .red)
							}
						}
					}
					.listStyle(.plain)
				}
			}
			.navigationTitle(viewModel.title)
			.navigationBarTitleDisplayMode(.inline)
			.toolbar {
				ToolbarItemGroup(placement: .bottomBar) {
					Image(systemName: "arrow.up")
						.resizable()
						.scaledToFit()
						.foregroundColor(.red)
						.frame(width: 16, height: 16)
						.padding(EdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4))
					Text(viewModel.uploadSpeed)
						.font(.subheadline)
					Spacer()
					Text(torrentsDescription)
					Spacer()
					Image(systemName: "arrow.down")
						.resizable()
						.scaledToFit()
						.foregroundColor(.green)
						.frame(width: 16, height: 16)
						.padding(EdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4))
					Text(viewModel.downloadSpeed)
						.font(.subheadline)
				}
			}
			.alert(TorrentsPagePresenter.credentialRequested, isPresented: $viewModel.showAlert) {
				TextField(TorrentsPagePresenter.username, text: $username)
					.textInputAutocapitalization(.never)
				SecureField(TorrentsPagePresenter.password, text: $password)
				Button(TorrentsPagePresenter.ok) {
					authenticate?(username, password)
					viewModel.showAlert.toggle()
					loadData?()
				}
			}
		}
		.onAppear {
			loadData?()
		}
		.refreshable {
			loadData?()
		}
	}
	
	private var torrentsDescription: String {
		let description = viewModel.torrents.count == 1 ? TorrentsPagePresenter.torrent : TorrentsPagePresenter.torrents
		return "\(viewModel.torrents.count) \(description)"
	}
}

struct TorrentsPage_Previews: PreviewProvider {
    static var previews: some View {
		TorrentsPage(
			viewModel: TorrentsPageViewModel(
				title: "Title",
				error: nil,
				uploadSpeed: "5,5 Mb/s",
				downloadSpeed: "5,5 Mb/s",
				torrents: [
					TorrentViewModel(
						name: "a name",
						error: "download error",
						eta: "-",
						completionPercentage: 0.5,
						completionPercentageString: "50%",
						downloaded: "5,4GB of 7,8GB",
						downloadSpeed: "-"
					),
					TorrentViewModel(
						name: "another name",
						eta: "ETA: 7h 12m 12s",
						completionPercentage: 0.75,
						completionPercentageString: "50%",
						downloaded: "5,4GB of 7,8GB",
						downloadSpeed: "5,6MB"
					)
				],
				showAlert: false,
				emptyMessage: nil
			)
		)
    }
}
