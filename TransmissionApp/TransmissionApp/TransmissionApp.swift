//
//  TransmissionApp.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 22/07/23.
//

import Combine
import SwiftUI
import Transmission

@main
struct TransmissionApp: App {
    var body: some Scene {
        WindowGroup {
			TransmissionComposer.torrentsPagePresentationAdapter()
		}
	}
}
