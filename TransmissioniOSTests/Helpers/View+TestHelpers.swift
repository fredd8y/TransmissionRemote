//
//  View+TestHelpers.swift
//  TransmissioniOSTests
//
//  Created by Federico Arvat on 19/07/23.
//

import SwiftUI

extension View {
	func snapshot(_ configuration: SnapshotConfiguration) -> UIImage {
		UIHostingController(rootView: self).snapshot(for: configuration)
	}
}
