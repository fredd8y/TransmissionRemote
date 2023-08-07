//
//  TorrentsPage.swift
//  TransmissioniOS
//
//  Created by Federico Arvat on 18/07/23.
//

import SwiftUI
import Transmission

public struct TorrentsPage: View {
	
	public init(model: TorrentsViewModel) {
		_title = State(initialValue: model.title)
		_error = State(initialValue: model.error)
		_uploadSpeed = State(initialValue: model.uploadSpeed)
		_downloadSpeed = State(initialValue: model.downloadSpeed)
		_torrents = State(initialValue: model.torrents)
	}
	
	@State private var title: String
	@State private var error: String?
	@State private var uploadSpeed: String
	@State private var downloadSpeed: String
	@State private var torrents: [TorrentViewModel]
	
    public var body: some View {
		NavigationStack {
			VStack {
				if let error {
					HStack {
						Spacer()
						SubheadlineText(error)
							.foregroundColor(Color.white)
							.padding()
							.multilineTextAlignment(.center)
						Spacer()
					}.background { Color.red }
				}
				List {
					ForEach(torrents) { torrent in
						VStack(alignment: .leading) {
							SubheadlineText(torrent.name).font(.subheadline)
							Caption2Text(torrent.downloaded)
							HStack {
								ProgressView(value: torrent.completionPercentage)
									.tint(torrent.error == nil ? .blue : .red)
								Caption2Text(torrent.completionPercentageString)
							}
							Caption2Text(torrent.error ?? torrent.eta)
								.foregroundColor(torrent.error == nil ? .primary : .red)
						}
					}
				}
				.listStyle(.plain)
			}
			.navigationTitle(title)
			.navigationBarTitleDisplayMode(.inline)
			.toolbar {
				ToolbarItemGroup(placement: .bottomBar) {
					Image(systemName: "arrow.up")
						.resizable()
						.scaledToFit()
						.foregroundColor(.red)
						.frame(width: 16, height: 16)
						.padding(EdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4))
					SubheadlineText("5,5MB")
					Spacer()
					Image(systemName: "arrow.down")
						.resizable()
						.scaledToFit()
						.foregroundColor(.green)
						.frame(width: 16, height: 16)
						.padding(EdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4))
					SubheadlineText("5,5MB")
				}
			}
		}
    }
}

struct TorrentsPage_Previews: PreviewProvider {
    static var previews: some View {
		TorrentsPage(
			model: TorrentsViewModel(
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
				]
			)
		)
    }
}
