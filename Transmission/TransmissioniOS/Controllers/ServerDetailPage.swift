//
//  ServerDetailPage.swift
//  TransmissioniOS
//
//  Created by Federico Arvat on 30/07/23.
//

import SwiftUI
import Transmission

public struct ServerDetailPage: View {
	
	private enum HTTPProtocol: String, CaseIterable {
		case http
		case https
	}
	
	public init(viewModel: ServerDetailPageViewModel) {
		self.viewModel = viewModel
		
		_title = State(initialValue: viewModel.title)
		_name = State(initialValue: viewModel.name ?? "")
		_httpProtocol = State(
			initialValue: HTTPProtocol(rawValue: viewModel.httpProtocol ?? "") ?? .http
		)
		_ip = State(initialValue: viewModel.ip ?? "")
		_port = State(initialValue: viewModel.port ?? "")
		_username = State(initialValue: viewModel.username ?? "")
		_password = State(initialValue: viewModel.password ?? "")
	}
	
	var viewModel: ServerDetailPageViewModel
	
	@State private var title: String
	@State private var name: String
	@State private var httpProtocol: HTTPProtocol
	@State private var ip: String
	@State private var port: String
	@State private var username: String
	@State private var password: String
	
	public var body: some View {
		NavigationStack {
			List {
				Section(viewModel.serverSectionHeader) {
					TextField(viewModel.namePlaceholder, text: $name)
					Picker(viewModel.protocolPlaceholder, selection: $httpProtocol) {
						ForEach(HTTPProtocol.allCases, id: \.self) {
							Text($0.rawValue)
						}
					}
					TextField(viewModel.ipPlaceholder, text: $ip)
					TextField(viewModel.portPlaceholder, text: $port)
				}
				Section(viewModel.authenticationSectionHeader) {
					TextField(viewModel.usernamePlaceholder, text: $username)
					TextField(viewModel.passwordPlaceholder, text: $password)
				}
			}.listStyle(.plain)
			.navigationTitle(viewModel.title)
			.navigationBarTitleDisplayMode(.inline)
			.toolbar {
				ToolbarItem {
					Button {
						// TODO
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
