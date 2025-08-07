//
//  CustomCoordinator.swift
//  BatteryTracker
//
//  Created by Baidetskyi Yurii on 07.08.2025.
//

import Foundation
import SwiftUI

public protocol CustomCoordinator: Coordinator {
    associatedtype DestinationView: View
    
    @MainActor
    func destination() -> DestinationView
}

@MainActor
public extension CustomCoordinator {
    
    var rootView: some View { destination().withModal(self) }
}
