//
//  TorrentPeersPage.swift
//  TransmissioniOS
//
//  Created by Federico Arvat on 20/08/23.
//

import SwiftUI
import Transmission

public struct TorrentPeersPage: View {
	
	public init(viewModel: TorrentPeersPageViewModel) {
		self.viewModel = viewModel
	}
	
	@ObservedObject var viewModel: TorrentPeersPageViewModel
	
	public var onAppear: (() -> Void)?
	
	public var onDisappear: (() -> Void)?
	
	
	public  var body: some View {
		VStack {
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
					ForEach(viewModel.peers, id: \.address) { peer in
						Section(peer.address) {
							VStack(alignment: .leading) {
								HStack {
									Text(TorrentPeersPagePresenter.percentage)
										.font(.subheadline)
									Spacer()
									Text(peer.percentage)
										.font(.subheadline)
								}
								HStack {
									Text(TorrentPeersPagePresenter.status)
										.font(.subheadline)
									Spacer()
									Text(peer.status)
										.font(.subheadline)
								}
								HStack {
									Text(TorrentPeersPagePresenter.client)
										.font(.subheadline)
									Spacer()
									Text(peer.client)
										.font(.subheadline)
								}
							}
						}
					}
				}
			}
		}
		.navigationTitle(TorrentPeersPagePresenter.title)
		.navigationBarTitleDisplayMode(.inline)
		.listStyle(.insetGrouped)
		.onAppear {
			onAppear?()
		}
		.onDisappear {
			onDisappear?()
		}
	}
}

struct TorrentPeersPage_Previews: PreviewProvider {
	static var previews: some View {
		TorrentPeersPage(
			viewModel: TorrentPeersPageViewModel(
				peers: [
					TorrentPeersPageViewModel.Peer(
						percentage: "97,00%",
						status: "Status",
						address: "Address",
						client: "Client"
					)
				],
				errorMessage: nil
			)
		)
	}
}
