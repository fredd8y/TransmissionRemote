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
	
	@Environment(\.isPresented) var isPresented
	
	@ObservedObject private var viewModel: ServerPageViewModel
	
	@State private var tabBarVisibility: Visibility = .hidden
    
    @AppStorage(ServerConstants.kLocalNetworkPermissionAlreadyAsked)
    private var localNetworkPermissionAlreadyAsked: Bool = false
	
	public var loadData: (() -> Void)?
	
	public var showServerDetail: ((UUID) -> ServerDetailPage?)?
	
	public var selectServer: ((UUID) -> Void)?
	
	public var deleteServer: ((UUID) -> Void)?
	
	public var newServer: (() -> ServerDetailPage)?
		
    public var body: some View {
		NavigationStack {
			VStack {
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
					List(viewModel.servers, selection: $viewModel.currentSelectedServerId) { server in
						HStack {
							VStack(alignment: .leading, spacing: 8) {
								Text(server.title)
									.font(.subheadline)
								Text(server.url)
									.font(.caption2)
							}
							if server.id == viewModel.currentSelectedServerId {
								Spacer()
								Image(systemName: "checkmark")
									.foregroundColor(.primary)
							}
						}.contextMenu {
							NavigationLink {
								showServerDetail?(server.id)
							} label: {
								Text(viewModel.editItemActionTitle)
							}
							Button(role: .destructive) {
								deleteServer?(server.id)
							} label: {
								Text(viewModel.deleteItemActionTitle)
							}
						}
					}
					.listStyle(.insetGrouped)
				}
			}
			.navigationTitle(viewModel.title)
			.navigationBarTitleDisplayMode(.inline)
			.toolbar {
				ToolbarItem(placement: .navigationBarTrailing) {
					NavigationLink {
						newServer?()
					} label: {
						Image(systemName: "plus")
							.foregroundColor(.primary)
					}
				}
			}
			.toolbar(tabBarVisibility, for: .tabBar)
			.onChange(of: viewModel.currentSelectedServerId) { newValue in
				guard let newValue else { return }
				selectServer?(newValue)
			}
		}
		.alert(
			ServerPagePresenter.alertErrorTitle,
			isPresented: $viewModel.alertMessageVisible,
			actions: {
				Button(action: {
					viewModel.alertMessage = nil
				}, label: {
					Text(ServerPagePresenter.ok)
				})
			},
			message: {
				Text(viewModel.alertMessage ?? "")
			}
		)
		.onLoad {
            if !localNetworkPermissionAlreadyAsked {
                localNetworkPermissionAlreadyAsked = true
                // This is done to trigger the OS to ask the local network
                // connectivity permission, this is done to avoid the user being
                // asked on the home page as the permission alert cause some weird lag
                _ = ProcessInfo.processInfo.hostName
            }
            loadData?()
        }
        .onChange(of: isPresented) { _ in
            withAnimation {
                tabBarVisibility = .visible
            }
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
				deleteItemActionTitle: "Delete",
				currentSelectedServerId: selectedId,
				emptyMessage: nil,
				alertMessage: nil,
				alertMessageVisible: false
			)
		)
    }
}
