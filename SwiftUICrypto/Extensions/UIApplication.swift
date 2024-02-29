//
//  UIApplication.swift
//  SwiftUICrypto
//
//  Created by M29002 on 25/6/23.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
