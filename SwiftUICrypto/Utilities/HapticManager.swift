//
//  HapticManager.swift
//  SwiftUICrypto
//
//  Created by M29002 on 26/8/23.
//

import Foundation
import UIKit

class HapticManager {
    static private let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}
