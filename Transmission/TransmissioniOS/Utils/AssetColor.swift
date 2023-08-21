//
//  AssetColor.swift
//  TransmissioniOS
//
//  Created by Federico Arvat on 21/08/23.
//

import SwiftUI

extension UIColor {
	/// Creates a UIColor from the asset with the specified name.
	///
	/// - Parameters:
	///   - name: The name of the color resource to lookup.
	///     The color will be searched in the the same bundle as the one who contain this initializer
	convenience init?(assetName: String) {
		self.init(named: assetName, in: Bundle(for: BundleConvenienceClass.self), compatibleWith: nil)
		/// The only purpose of this class is to be used to access the Bundle using the
		/// Bundle(for:) initializer, due to the fact that in this target there are only structs.
		class BundleConvenienceClass {}
	}
}
