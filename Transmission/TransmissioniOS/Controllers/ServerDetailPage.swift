//
//  ServerDetailPage.swift
//  TransmissioniOS
//
//  Created by Federico Arvat on 30/07/23.
//

import SwiftUI
import Transmission

public struct ServerDetailPage: View {
	
	public enum ServerDetailPageError: Error {
		case name
		case ip
		case port
		case username
		case password
	}
	
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
			password: viewModel.password ?? "",
			id: viewModel.serverId
		))
	}
	
	public var save: ((ServerDetailPageDataModel) -> Error?)?
		
	private var viewModel: ServerDetailPageViewModel
	
	@State private var title: String
	
	@State private var dataModel: ServerDetailPageDataModel
	
	@State private var error: ServerDetailPageError?
	
	public var body: some View {
		NavigationStack {
			List {
				Section(ServerDetailPagePresenter.serverSectionHeader) {
					VStack(alignment: .leading) {
						Text(ServerDetailPagePresenter.namePlaceholder)
							.font(.caption)
						TextField(ServerDetailPagePresenter.namePlaceholder, text: $dataModel.name)
						if error == .name {
							Text(ServerDetailPagePresenter.nameError)
								.foregroundColor(.red)
								.font(.caption)
						}
					}
					Picker(ServerDetailPagePresenter.protocolPlaceholder, selection: $dataModel.httpProtocol) {
						ForEach(HTTPProtocol.allCases, id: \.self) {
							switch $0 {
							case .http:
								Text("http")
							case .https:
								Text("https")
							}
						}
					}
					VStack(alignment: .leading) {
						Text(ServerDetailPagePresenter.ipPlaceholder)
							.font(.caption)
						TextField(ServerDetailPagePresenter.ipPlaceholder, text: $dataModel.ip)
						if error == .ip {
							Text(ServerDetailPagePresenter.ipError)
								.foregroundColor(.red)
								.font(.caption)
						}
					}
					VStack(alignment: .leading) {
						Text(ServerDetailPagePresenter.portPlaceholder)
							.font(.caption)
						TextField(ServerDetailPagePresenter.portPlaceholder, text: $dataModel.port)
						if error == .port {
							Text(ServerDetailPagePresenter.portError)
								.foregroundColor(.red)
								.font(.caption)
						}
					}
				}
				Section(ServerDetailPagePresenter.authenticationSectionHeader) {
					VStack(alignment: .leading) {
						Text(ServerDetailPagePresenter.usernamePlaceholder)
							.font(.caption)
						TextField(ServerDetailPagePresenter.usernamePlaceholder, text: $dataModel.username)
						if error == .username {
							Text(ServerDetailPagePresenter.usernameError)
								.foregroundColor(.red)
								.font(.caption)
						}
					}
					VStack(alignment: .leading) {
						Text(ServerDetailPagePresenter.passwordPlaceholder)
							.font(.caption)
						SecureField(ServerDetailPagePresenter.passwordPlaceholder, text: $dataModel.password)
						if error == .password {
							Text(ServerDetailPagePresenter.passwordError)
								.foregroundColor(.red)
								.font(.caption)
						}
					}
				}
			}.listStyle(.insetGrouped)
			.navigationTitle(viewModel.title)
			.navigationBarTitleDisplayMode(.inline)
			.toolbar {
				ToolbarItem {
					Button {
						error = save?(dataModel) as? ServerDetailPageError
						if error == nil {
							dismiss()
						}
					} label: {
						Text(viewModel.saveButtonTitle)
					}.foregroundColor(.primary)
				}
			}
			.toolbar(.hidden, for: .tabBar)
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
				passwordPlaceholder: "Password",
				serverId: UUID()
			)
		)
    }
}
