//
//  HomeUseCase.swift
//  BatteryTracker
//
//  Created by Baidetskyi Yurii on 18.05.2025.
//

import Foundation

final class HomeUseCase {
    
    // MARK: - Properties
    private let repository: HomeRepositoryProtocol
    
    // MARK: - Init methods
    init(repository: HomeRepositoryProtocol) {
        self.repository = repository
    }
}

// MARK: - Interface methods
extension HomeUseCase: HomeUseCaseProtocol {
    func sendBatteryInfo(info: BatteryInfo) async throws {
        return try await repository.sendBatteryInfo(info: info)
    }
}
