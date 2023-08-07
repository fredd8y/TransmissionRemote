//
//  Text+.swift
//  TransmissioniOS
//
//  Created by Federico Arvat on 19/07/23.
//

import SwiftUI

struct SubheadlineText: View {
	init(_ text: String) {
		_text = State(initialValue: text)
	}
	
	@State var text: String
	
	var body: some View {
		Text(text).font(.subheadline)
	}
}

struct Caption2Text: View {
	init(_ text: String) {
		_text = State(initialValue: text)
	}
	
	@State var text: String
	
	var body: some View {
		Text(text).font(.caption2)
	}
}
