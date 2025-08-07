//
//  BatteryMonitorManager.swift
//  BatteryTracker Development
//
//  Created by Baidetskyi Yurii on 07.08.2025.
//

import Foundation
import Combine
import UIKit

/// A protocol that defines the requirements for monitoring battery information.
protocol BatteryMonitorProtocol: ObservableObject {
    /// The current battery information, including level, state, and timestamp.
    var batteryInfo: BatteryInfo { get }
}

/// A class responsible for monitoring battery level and state,
/// updating it periodically and when system battery notifications occur.
/// It supports background task execution for data updates.
final class BatteryMonitorManager: BatteryMonitorProtocol {
    
    /// Published property that holds the latest battery information.
    @Published var batteryInfo: BatteryInfo = .init(level: 0.0, state: .unknown, timestamp: Date())
    
    /// Set of Combine cancellables used to manage subscriptions.
    private var cancellables = Set<AnyCancellable>()
    
    /// Identifier for the currently running background task.
    private var backgroundTask: UIBackgroundTaskIdentifier = .invalid
    
    /// Initializes a new instance of `BatteryMonitorManager`,
    /// enabling battery monitoring and setting up observers and polling.
    init() {
        UIDevice.current.isBatteryMonitoringEnabled = true
        
        #if targetEnvironment(simulator)
        // Simulated values for testing in Simulator
        batteryInfo = BatteryInfo(level: 0.5, state: .charging, timestamp: Date())
        #else
        // Initial battery update
        updateBatteryInfo()
        
        // Observe battery level/state changes
        NotificationCenter.default.publisher(for: UIDevice.batteryLevelDidChangeNotification)
            .merge(with: NotificationCenter.default.publisher(for: UIDevice.batteryStateDidChangeNotification))
            .sink { [weak self] _ in
                self?.updateBatteryInfo()
            }
            .store(in: &cancellables)
        
        // Poll battery info every 2 minutes using Combine and background task support
        Timer.publish(every: 120.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.runWithBackgroundTask {
                    self?.updateBatteryInfo()
                }
            }
            .store(in: &cancellables)
        #endif
    }
    
    /// Cleans up battery monitoring and cancels all Combine subscriptions.
    deinit {
        UIDevice.current.isBatteryMonitoringEnabled = false
        cancellables.forEach { $0.cancel() }
    }
}

// MARK: - Private Methods
private extension BatteryMonitorManager {
    
    /// Updates the `batteryInfo` property with the current battery level, state, and timestamp.
    func updateBatteryInfo() {
        batteryInfo = BatteryInfo(
            level: UIDevice.current.batteryLevel,
            state: UIDevice.current.batteryState,
            timestamp: Date()
        )
    }
    
    /// Wraps the provided work in a background task to ensure execution even if the app goes to background.
    ///
    /// - Parameter work: A closure containing the work to perform.
    func runWithBackgroundTask(_ work: @escaping () -> Void) {
        backgroundTask = UIApplication.shared.beginBackgroundTask(withName: "BatteryUpdate") {
            // Cleanup if background time expires
            UIApplication.shared.endBackgroundTask(self.backgroundTask)
            self.backgroundTask = .invalid
        }
        
        work()
        
        if backgroundTask != .invalid {
            UIApplication.shared.endBackgroundTask(backgroundTask)
            backgroundTask = .invalid
        }
    }
}
