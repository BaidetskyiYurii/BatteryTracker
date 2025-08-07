//
//  SendBatteryInfoRequestDTO.swift
//  BatteryTracker
//
//  Created by Baidetskyi Yurii on 19.05.2025.
//

import Foundation

struct SendBatteryInfoRequestDTO: Parameterable {
    let level: Float
    let state: String
    let timestamp: Date
}
