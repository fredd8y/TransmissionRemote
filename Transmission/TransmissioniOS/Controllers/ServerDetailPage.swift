//
//  ServerDetailPage.swift
//  TransmissioniOS
//
//  Created by Federico Arvat on 30/07/23.
//

import SwiftUI
import Transmission

public struct ServerDetailPage: View {
	
	@Environment(\.dismiss) var dismiss
	
	public init(viewModel: ServerDetailPageViewModel) {
		self.viewModel = viewModel
		
		_title = State(initialValue: viewModel.title)
		_dataModel = State(initialValue: ServerDetailPageDataModel(
			name: viewModel.name ?? "",
			httpProtocol: viewModel.httpProtocol ?? .http,
			ip: viewModel.ip ?? "",
			port: viewModel.port ?? "",
			username: viewModel.username ?? "",
			password: viewModel.password ?? ""
		))
	}
	
	public var save: ((ServerDetailPageDataModel) -> Error?)?
	
	private var viewModel: ServerDetailPageViewModel
	
	@State private var title: String
	@State private var dataModel: ServerDetailPageDataModel
	@State private var error: Error?
	
	public var body: some View {
		NavigationStack {
			List {
				Section(viewModel.serverSectionHeader) {
					TextField(viewModel.namePlaceholder, text: $dataModel.name)
					Picker(viewModel.protocolPlaceholder, selection: $dataModel.httpProtocol) {
						ForEach(HTTPProtocol.allCases, id: \.self) {
							switch $0 {
							case .http:
								Text("http")
							case .https:
								Text("https")
							}
						}
					}
					TextField(viewModel.ipPlaceholder, text: $dataModel.ip)
					TextField(viewModel.portPlaceholder, text: $dataModel.port)
				}
				Section(viewModel.authenticationSectionHeader) {
					TextField(viewModel.usernamePlaceholder, text: $dataModel.username)
					TextField(viewModel.passwordPlaceholder, text: $dataModel.password)
				}
			}.listStyle(.plain)
			.navigationTitle(viewModel.title)
			.navigationBarTitleDisplayMode(.inline)
			.toolbar {
				ToolbarItem {
					Button {
						error = save?(dataModel)
						if error == nil {
							dismiss()
						}
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
