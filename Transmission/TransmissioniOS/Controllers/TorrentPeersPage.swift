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
		UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(assetName: "pageControlCurrentPageIndicatorTintColor")
		UIPageControl.appearance().pageIndicatorTintColor = UIColor(assetName: "pageControlPageIndicatorTintColor")
	}
	
	@ObservedObject var viewModel: TorrentPeersPageViewModel
	
	public var onAppear: (() -> Void)?
	
	public var onDisappear: (() -> Void)?
	
	
	public  var body: some View {
		List {
			ForEach(viewModel.peers, id: \.address) { peer in
				Section(peer.address) {
					VStack(alignment: .leading) {
						HStack {
							Text("Percentage")
							Spacer()
							Text(peer.percentage)
						}
						HStack {
							Text("Status")
							Spacer()
							Text(peer.status)
						}
						HStack {
							Text("Client")
							Spacer()
							Text(peer.client)
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
				]
			)
		)
	}
}
