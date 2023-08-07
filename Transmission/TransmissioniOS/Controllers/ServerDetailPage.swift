//
//  ServerDetailPage.swift
//  TransmissioniOS
//
//  Created by Federico Arvat on 30/07/23.
//

import SwiftUI
import Transmission

struct ServerDetailPage: View {
	
	private enum HTTPProtocol: String, CaseIterable {
		case http
		case https
	}
	
	init(viewModel: ServerDetailPageViewModel) {
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
	
	var body: some View {
		NavigationStack {
			Form {
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
			}
			.navigationTitle(viewModel.title)
			.navigationBarTitleDisplayMode(.inline)
		}
	}
}

struct ServerDetailPage_Previews: PreviewProvider {
    static var previews: some View {
		ServerDetailPage(
			viewModel: ServerDetailPageViewModel(
				serverSectionHeader: "Server detail",
				authenticationSectionHeader: "Authentication detail",
				title: "Server",
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
