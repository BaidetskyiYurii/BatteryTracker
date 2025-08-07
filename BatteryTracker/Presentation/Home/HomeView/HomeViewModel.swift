//
//  HomeViewModel.swift
//  BatteryTracker
//
//  Created by Baidetskyi Yurii on 07.08.2025.
//

import Foundation

/// ViewModel responsible for handling home screen logic, including sending battery data.
final class HomeViewModel: HomeViewModelProtocol {
    
    // MARK: - Properties
    
    /// Use case providing business logic and networking for the Home module.
    private let homeUseCase: HomeUseCaseProtocol
    
    // MARK: - Initialization
    
    /// Initializes a new instance of `HomeViewModel`.
    ///
    /// - Parameter homeUseCase: A conforming use case instance to handle data-related logic.
    init(homeUseCase: HomeUseCaseProtocol) {
        self.homeUseCase = homeUseCase
    }
}

// MARK: - Public Methods

extension HomeViewModel {
    
    /// Sends battery information to the backend via the use case.
    ///
    /// - Parameter info: The `BatteryInfo` object to send.
    @MainActor
    func sendBatteryInfo(info: BatteryInfo) async {
        do {
            try await homeUseCase.sendBatteryInfo(info: info)
        } catch {
            Log.error("Sending battery info failed: \(error)")
        }
    }
}
