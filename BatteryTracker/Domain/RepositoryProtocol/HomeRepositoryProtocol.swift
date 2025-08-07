//
//  HomeRepositoryProtocol.swift
//  BatteryTracker
//
//  Created by Baidetskyi Yurii on 18.05.2025.
//

import Foundation

protocol HomeRepositoryProtocol {
    func sendBatteryInfo(info: BatteryInfo) async throws
}
