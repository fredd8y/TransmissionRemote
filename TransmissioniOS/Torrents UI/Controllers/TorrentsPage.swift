//
//  TorrentsPage.swift
//  TransmissioniOS
//
//  Created by Federico Arvat on 18/07/23.
//

import SwiftUI
import Transmission

public struct TorrentsPage: View {
	
	/// Typealias created to avoid having to import Transmission framework
	/// when using this struct
	public typealias TorrentViewModel = Transmission.TorrentViewModel
	
	public init(title: String, torrents: [TorrentViewModel], error: String?) {
		_title = State(initialValue: title)
		_error = State(initialValue: error)
		_torrents = State(initialValue: torrents)
	}
	
	@State private var title: String
	@State private var error: String?
	@State private var torrents: [TorrentViewModel]
	
    public var body: some View {
		NavigationView {
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
								Caption2Text(torrent.completionPercentageString)
							}
							Caption2Text(torrent.eta)
						}
					}
				}
				.listStyle(.plain)
			}
			.navigationTitle(title)
			.navigationBarTitleDisplayMode(.inline)
		}
    }
}

struct TorrentsPage_Previews: PreviewProvider {
    static var previews: some View {
		TorrentsPage(
			title: "Title",
			torrents: [
				TorrentViewModel(
					name: "a name",
					eta: "ETA: 6d 7h 54m 33s",
					completionPercentage: 0.5,
					completionPercentageString: "50%",
					downloaded: "5,4GB of 7,8GB",
					downloadSpeed: "5,6MB"
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
			error: nil
		)
    }
}
