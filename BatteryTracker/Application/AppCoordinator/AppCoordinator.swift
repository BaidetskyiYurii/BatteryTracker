//
//  AppCoordinator.swift
//  BatteryTracker
//
//  Created by Baidetskyi Yurii on 24.06.2025.
//

import Foundation
import SwiftUI

final class AppCoordinator {
    enum AppFlow: Hashable, CaseIterable {
        case home
    }
    
    @Published private(set) var currentFlow: AppFlow = .home
    
    private let homeFlow = HomeFlowCoordinator()
}

// MARK: - CustomCoordinator
extension AppCoordinator: CustomCoordinator {
    // root view
    func destination() -> some View {
        RootView(coordinator: self)
    }
    
    @MainActor @ViewBuilder
    func view(for flow: AppFlow) -> some View {
        switch flow {
        case .home:
            homeFlow.oldView(for: .home)
        }
    }
}

// MARK: - Root View
extension AppCoordinator {
    struct RootView: View {
        @ObservedObject var coordinator: AppCoordinator
        
        var body: some View {
            coordinator.view(for: coordinator.currentFlow)
        }
    }
}
