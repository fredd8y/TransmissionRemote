//
//  ServerPage.swift
//  TransmissioniOS
//
//  Created by Federico Arvat on 29/07/23.
//

import SwiftUI
import Transmission

public struct ServerPage: View {
	
	public init(viewModel: ServerPageViewModel) {
		self.viewModel = viewModel
	}
	
	@ObservedObject var viewModel: ServerPageViewModel
	
	public var loadData: (() -> Void)?
	
	public var selectedServer: ((UUID) -> ServerDetailPage?)?
	
	public var newServer: (() -> ServerDetailPage)?
		
    public var body: some View {
		NavigationStack {
			List(viewModel.servers, selection: $viewModel.currentSelectedServerId) { server in
				VStack(alignment: .leading, spacing: 8) {
					Text(server.title)
						.font(.subheadline)
					Text(server.url)
						.font(.caption2)
				}.contextMenu {
					NavigationLink {
						selectedServer?(server.id)
					} label: {
						Text(viewModel.editItemActionTitle)
					}
				}
			}
			.listStyle(.plain)
			.navigationTitle(viewModel.title)
			.navigationBarTitleDisplayMode(.inline)
			.toolbar {
				ToolbarItem(placement: .navigationBarTrailing) {
					NavigationLink {
						newServer?()
					} label: {
						Image(systemName: "plus").foregroundColor(.primary)
					}
				}
			}
		}.onAppear {
			loadData?()
		}
    }
}

struct ServerPage_Previews: PreviewProvider {
    static var previews: some View {
		let selectedId = UUID()
        ServerPage(
			viewModel: ServerPageViewModel(
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
				editItemActionTitle: "Edit",
				currentSelectedServerId: selectedId
			)
		)
    }
}
