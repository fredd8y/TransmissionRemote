//
//  CreditsPage.swift
//  TransmissioniOS
//
//  Created by Federico Arvat on 16/08/23.
//

import SwiftUI
import Transmission

struct CreditsPage: View {
	
	@Environment(\.isPresented) var isPresented
	
	@State private var tabBarVisibility: Visibility = .visible
	
    var body: some View {
		NavigationStack {
			List {
				VStack(alignment: .leading) {
					Image(assetName: "turtle")
						.renderingMode(.template)
						.resizable()
						.frame(width: 30, height: 30)
					Link(destination: URL(string: "https://www.flaticon.com/free-icons/turtle")!) {
						Text(CreditsPagePresenter.turtleIconCredit)
					}.font(.caption)
				}
			}
			.listStyle(.insetGrouped)
			.navigationTitle(CreditsPagePresenter.title)
			.navigationBarTitleDisplayMode(.inline)
			.toolbar(tabBarVisibility, for: .tabBar)
		}
		.onLoad {
			withAnimation {
				tabBarVisibility = .hidden
			}
		}
		.onChange(of: isPresented) { _ in
			withAnimation {
				tabBarVisibility = .visible
			}
		}
    }
}

struct CreditsPage_Previews: PreviewProvider {
    static var previews: some View {
        CreditsPage()
    }
}
