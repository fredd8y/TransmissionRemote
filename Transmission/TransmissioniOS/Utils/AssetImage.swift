//
//  AssetImage.swift
//  TransmissioniOS
//
//  Created by Federico Arvat on 16/08/23.
//

import SwiftUI

extension Image {
	/// Creates a labeled image that you can use as content for controls.
	///
	/// - Parameters:
	///   - name: The name of the image resource to lookup.
	///     The image will be searched in the the same bundle as the one who contain this initializer
	init(assetName: String) {
		self.init(assetName, bundle: Bundle(for: BundleConvenienceClass.self))
		/// The only purpose of this class is to be used to access the Bundle using the
		/// Bundle(for:) initializer, due to the fact that in this target there are only structs.
		class BundleConvenienceClass {}
	}
}
