//
//  HomeRepository.swift
//  BatteryTracker
//
//  Created by Baidetskyi Yurii on 19.05.2025.
//

import Foundation

final class HomeRepository {
    
    // MARK: - Properties
    private let api: HomeAPIProtocol
    private let reachability: ReachabilityProtocol
    
    init(api: HomeAPIProtocol,
         reachability: ReachabilityProtocol) {
        self.api = api
        self.reachability = reachability
    }
}

// MARK: - HomeRepositoryProtocol impementation
extension HomeRepository: HomeRepositoryProtocol {
    func sendBatteryInfo(info: BatteryInfo) async throws {
        guard reachability.isConnected else {
            throw ReachabilityError.notConnected
        }
        
        try await api.sendBatteryInfo(info: info)
    }
}
