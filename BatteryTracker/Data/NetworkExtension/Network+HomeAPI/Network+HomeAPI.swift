//
//  Network+HomeAPI.swift
//  BatteryTracker
//
//  Created by Baidetskyi Yurii on 19.05.2025.
//

import Foundation

extension NetworkService: HomeAPIProtocol where R == HomeRoutes {
    func sendBatteryInfo(info: BatteryInfo) async throws {
        let requestDTO: SendBatteryInfoRequestDTO = info.toRequestDTO()
        
        let _ = try await self.request(
            .sendBatteryInfo(baseURL, requestDTO)
        )
    }
}
