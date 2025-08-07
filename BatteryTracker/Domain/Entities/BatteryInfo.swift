//
//  BatteryInfo.swift
//  BatteryTracker
//
//  Created by Baidetskyi Yurii on 18.05.2025.
//

import Foundation
import UIKit

struct BatteryInfo {
    let level: Float
    let state: UIDevice.BatteryState
    let timestamp: Date
}

extension BatteryInfo: Equatable, Hashable {}

extension BatteryInfo {
    func toRequestDTO() -> SendBatteryInfoRequestDTO {
        .init(level: level, state: state.description, timestamp: timestamp)
    }
}
