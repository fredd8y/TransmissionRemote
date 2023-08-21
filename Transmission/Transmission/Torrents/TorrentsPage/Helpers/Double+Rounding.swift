//
//  Double+Rounding.swift
//  Transmission
//
//  Created by Federico Arvat on 20/07/23.
//

import Foundation

extension Double {
	func round(fractionDigit: Int = 2) -> String? {
		let numberFormatter = NumberFormatter()
		numberFormatter.numberStyle = .decimal
		numberFormatter.roundingMode = .halfDown
		numberFormatter.decimalSeparator = ","
		numberFormatter.minimumFractionDigits = 2
		numberFormatter.maximumFractionDigits = 2
		return numberFormatter.string(from: self as NSNumber)
	}
}
