//
//  UIDevice+Extensions.swift
//  BatteryTracker Development
//
//  Created by Baidetskyi Yurii on 07.08.2025.
//

import Foundation
import UIKit

extension UIDevice.BatteryState {
    var description: String {
        switch self {
        case .charging: return "Charging"
        case .full: return "Full"
        case .unplugged: return "Unplugged"
        default: return "Unknown"
        }
    }
}
