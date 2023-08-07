//
//  DidLoadModifier.swift
//  TransmissioniOS
//
//  Created by Federico Arvat on 07/08/23.
//

import SwiftUI

struct DidLoadModifier: ViewModifier {
	@State private var loaded: Bool = false
	
	private var action: (() -> Void)?
	
	init(perform action: (() -> Void)? = nil) {
		self.action = action
	}
	
	func body(content: Content) -> some View {
		content.onAppear {
			guard !loaded else { return }
			loaded = true
			action?()
		}
	}
}

extension View {
	public func onLoad(perform action: (() -> Void)? = nil) -> some View {
		modifier(DidLoadModifier(perform: action))
	}
}
