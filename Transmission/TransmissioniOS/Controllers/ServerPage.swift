//
//  ServerPage.swift
//  TransmissioniOS
//
//  Created by Federico Arvat on 29/07/23.
//

import SwiftUI
import Transmission

public struct ServerPage: View {
	public init(viewModel: ServersViewModel) {
		self.viewModel = viewModel
		selection = viewModel.currentSelectedServer
	}
	
	@ObservedObject var viewModel: ServersViewModel
		
	@State private var selection: UUID?
	
    public var body: some View {
		NavigationStack {
			List(viewModel.servers, selection: $selection) { server in
				VStack(alignment: .leading, spacing: 8) {
					Text(server.title)
						.font(.subheadline)
					Text(server.url)
						.font(.caption2)
				}
			}
			.listStyle(.plain)
			.navigationTitle(viewModel.title)
			.navigationBarTitleDisplayMode(.inline)
		}
    }
}

struct ServerPage_Previews: PreviewProvider {
    static var previews: some View {
		let selectedId = UUID()
        ServerPage(
			viewModel: ServersViewModel(
				title: "Servers",
				servers: [
					ServerViewModel(
						title: "Raspberry",
						url: "http://192.168.1.1:9091",
						id: selectedId
					),
					ServerViewModel(
						title: "NAS",
						url: "http://192.168.1.2:9091",
						id: UUID()
					)
				],
				currentSelectedServer: selectedId
			)
		)
    }
}
