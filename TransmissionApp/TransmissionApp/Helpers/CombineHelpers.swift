//
//  CombineHelpers.swift
//  TransmissionApp
//
//  Created by Federico Arvat on 24/07/23.
//

import Combine
import Foundation
import Transmission

public extension HTTPClient {
	typealias Publisher = AnyPublisher<(Data, HTTPURLResponse), Error>
	
	func postPublisher(url: URL, body: Data, additionalHeader: [String: String]? = nil) -> Publisher {
		return Deferred {
			Future { completion in
				self.post(url, body: body, additionalHeader: additionalHeader, completion: completion)
			}
		}.eraseToAnyPublisher()
	}
}

extension Publisher {
	func dispatchOnMainQueue() -> AnyPublisher<Output, Failure> {
		receive(on: DispatchQueue.immediateWhenOnMainQueueScheduler).eraseToAnyPublisher()
	}
}

extension DispatchQueue {
	static var immediateWhenOnMainQueueScheduler: ImmediateWhenOnMainQueueScheduler {
		ImmediateWhenOnMainQueueScheduler.shared
	}
	
	struct ImmediateWhenOnMainQueueScheduler: Scheduler {
		typealias SchedulerTimeType = DispatchQueue.SchedulerTimeType
		typealias SchedulerOptions = DispatchQueue.SchedulerOptions
		
		var now: SchedulerTimeType {
			DispatchQueue.main.now
		}
		
		var minimumTolerance: SchedulerTimeType.Stride {
			DispatchQueue.main.minimumTolerance
		}
		
		static let shared = Self()
		
		private static let key = DispatchSpecificKey<UInt8>()
		private static let value = UInt8.max
		
		private init() {
			DispatchQueue.main.setSpecific(key: Self.key, value: Self.value)
		}
		
		private func isMainQueue() -> Bool {
			DispatchQueue.getSpecific(key: Self.key) == Self.value
		}
		
		func schedule(options: SchedulerOptions?, _ action: @escaping () -> Void) {
			guard isMainQueue() else {
				return DispatchQueue.main.schedule(options: options, action)
			}
			
			action()
		}
		
		func schedule(after date: SchedulerTimeType, tolerance: SchedulerTimeType.Stride, options: SchedulerOptions?, _ action: @escaping () -> Void) {
			DispatchQueue.main.schedule(after: date, tolerance: tolerance, options: options, action)
		}
		
		func schedule(after date: SchedulerTimeType, interval: SchedulerTimeType.Stride, tolerance: SchedulerTimeType.Stride, options: SchedulerOptions?, _ action: @escaping () -> Void) -> Cancellable {
			DispatchQueue.main.schedule(after: date, interval: interval, tolerance: tolerance, options: options, action)
		}
	}
}
