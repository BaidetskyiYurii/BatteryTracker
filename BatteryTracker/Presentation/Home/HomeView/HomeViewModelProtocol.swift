//
//  HomeViewModelProtocol.swift
//  BatteryTracker
//
//  Created by Baidetskyi Yurii on 02.06.2025.
//

import Foundation

protocol HomeViewModelProtocol: ObservableObject {
    func sendBatteryInfo(info: BatteryInfo) async
}
