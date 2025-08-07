//
//  Reachability.swift
//  BatteryTracker
//
//  Created by Baidetskyi Yurii on 19.05.2025.
//

import Combine
import Network

final class Reachability: ObservableObject {
    @Published private(set) var isMonitoring = false
    @Published private(set) var pathStatus = NWPath.Status.requiresConnection
    @Published private(set) var isConnected: Bool = true
    
    private var monitor: NWPathMonitor?
    private let queue = DispatchQueue(label: "NetworkStatus_Monitor")
    
    init() { startMonitoring() }
    
    deinit { stopMonitoring() }
}

extension Reachability: ReachabilityProtocol {
    
    func startMonitoring() {
        guard !isMonitoring else { return }
        
        monitor = NWPathMonitor()
        monitor?.start(queue: queue)
        monitor?.pathUpdateHandler = { [weak self] path in
            guard let self else { return }
            // Monitor runs on a background thread so we need to publish it on the main thread
            DispatchQueue.main.async {
                if self.pathStatus != path.status {
                    self.pathStatus = path.status
                    self.isConnected = self.pathStatus == .satisfied  ? true : false
                }
            }
        }
        isMonitoring = true
    }
    
    func stopMonitoring() {
        guard isMonitoring, let monitor else { return }
        monitor.cancel()
        self.monitor = nil
        isMonitoring = false
    }
}
