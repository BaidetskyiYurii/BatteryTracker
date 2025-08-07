//
//  View+Extensions.swift
//  BatteryTracker
//
//  Created by Baidetskyi Yurii on 07.08.2025.
//

import SwiftUI

extension View {
    /// Presents a semi-transparent loading overlay with spinner.
    func loadingOverlay(_ isLoading: Binding<Bool>) -> some View {
        modifier(LoadingModifier(isLoading: isLoading))
    }
}
