//
//  HomeView.swift
//  BatteryTracker
//
//  Created by Baidetskyi Yurii on 07.08.2025.
//

import SwiftUI
import FactoryKit

struct HomeView: View {
    @EnvironmentObject var appCoordinator: Navigation<AppCoordinator>
    @EnvironmentObject var coordinator: Navigation<HomeFlowCoordinator>
    
    @StateObject private var viewModel: HomeViewModel
    @StateObject private var batteryManager: BatteryMonitorManager
    
    init(homeUseCase: HomeUseCaseProtocol) {
        _viewModel = StateObject(wrappedValue: HomeViewModel(homeUseCase: homeUseCase))
        _batteryManager = StateObject(wrappedValue: BatteryMonitorManager())
    }
    
    var body: some View {
        content
            .navigationTitle(LS.Home.title)
            .onChange(of: batteryManager.batteryInfo) { info in
                Task {
                    await viewModel.sendBatteryInfo(info: info)
                }
            }
    }
}

// MARK: Private UI
private extension HomeView {
    var content: some View {
        VStack(spacing: 20) {
            Text("🔋 \(LS.Home.batteryLevel) \(Int(batteryManager.batteryInfo.level * 100))%")
            Text("⚡️ \(LS.Home.state) \(batteryManager.batteryInfo.state.description)")
        }
        .font(Fonts.Poppins.bold.swiftUIFont(size: 15))
        .padding()
        .background(MovingShapesView())
    }
}

#Preview {
    @Injected(\.mockHomeUseCase) var mockHomeUseCase
    HomeView(homeUseCase: mockHomeUseCase)
}
