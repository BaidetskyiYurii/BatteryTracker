//
//  BatteryTrackerApp.swift
//  BatteryTracker
//
//  Created by Baidetskyi Yurii on 18.05.2025.
//

import SwiftUI

@main
struct BatteryTrackerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @StateObject var appCoordinator = AppCoordinator()
    
    var body: some Scene {
        WindowGroup {
            appCoordinator.rootView
        }
    }
}
