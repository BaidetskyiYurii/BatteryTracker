//
//  HomeAPIProtocol.swift
//  BatteryTracker
//
//  Created by Baidetskyi Yurii on 19.05.2025.
//

import Foundation

protocol HomeAPIProtocol {
    func sendBatteryInfo(info: BatteryInfo) async throws
}
