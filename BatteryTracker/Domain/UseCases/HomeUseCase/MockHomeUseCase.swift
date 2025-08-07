//
//  MockHomeUseCase.swift
//  BatteryTracker
//
//  Created by Baidetskyi Yurii on 07.08.2025.
//

import Foundation

final class MockHomeUseCase {
    
    // MARK: - Properties
    private let repository: HomeRepositoryProtocol
    
    // MARK: - Init methods
    init(repository: HomeRepositoryProtocol) {
        self.repository = repository
    }
}

// MARK: - Interface methods
extension MockHomeUseCase: HomeUseCaseProtocol {
    func sendBatteryInfo(info: BatteryInfo) async throws {}
}
