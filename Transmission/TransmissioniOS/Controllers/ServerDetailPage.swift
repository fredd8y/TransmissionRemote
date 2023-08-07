//
//  ServerDetailPage.swift
//  TransmissioniOS
//
//  Created by Federico Arvat on 30/07/23.
//

import SwiftUI
import Transmission

public struct ServerDetailPage: View {
	
	public init(viewModel: ServerDetailPageViewModel) {
		self.viewModel = viewModel
		
		_title = State(initialValue: viewModel.title)
		model = ServerDetailPageDataModel(
			name: viewModel.name ?? "",
			httpProtocol: viewModel.httpProtocol ?? .http,
			ip: viewModel.ip ?? "",
			port: viewModel.port ?? "",
			username: viewModel.username ?? "",
			password: viewModel.password ?? ""
		)
	}
	
	public var save: ((ServerDetailPageDataModel) -> Error?)?
	
	private var viewModel: ServerDetailPageViewModel
	
	@State private var title: String
	@State private var model: ServerDetailPageDataModel
	@State private var error: Error?
	
	public var body: some View {
		NavigationStack {
			List {
				Section(viewModel.serverSectionHeader) {
					TextField(viewModel.namePlaceholder, text: $model.name)
					Picker(viewModel.protocolPlaceholder, selection: $model.httpProtocol) {
						ForEach(HTTPProtocol.allCases, id: \.self) {
							switch $0 {
							case .http:
								Text("http")
							case .https:
								Text("https")
							}
						}
					}
					TextField(viewModel.ipPlaceholder, text: $model.ip)
					TextField(viewModel.portPlaceholder, text: $model.port)
				}
				Section(viewModel.authenticationSectionHeader) {
					TextField(viewModel.usernamePlaceholder, text: $model.username)
					TextField(viewModel.passwordPlaceholder, text: $model.password)
				}
			}.listStyle(.plain)
			.navigationTitle(viewModel.title)
			.navigationBarTitleDisplayMode(.inline)
			.toolbar {
				ToolbarItem {
					Button {
						error = save?(model)
					} label: {
						Text(viewModel.saveButtonTitle)
					}.foregroundColor(.primary)
				}
			}
		}
	}
}

struct ServerDetailPage_Previews: PreviewProvider {
    static var previews: some View {
		ServerDetailPage(
			viewModel: ServerDetailPageViewModel(
				serverSectionHeader: "SERVER DETAIL",
				authenticationSectionHeader: "AUTHENTICATION DETAIL",
				title: "Server",
				saveButtonTitle: "Save",
				namePlaceholder: "Name",
				protocolPlaceholder: "Protocol",
				ipPlaceholder: "IP",
				portPlaceholder: "Port",
				usernamePlaceholder: "Username",
				passwordPlaceholder: "Password"
			)
		)
    }
}
