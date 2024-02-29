//
//  String.swift
//  SwiftUICrypto
//
//  Created by M29002 on 29/8/23.
//

import Foundation

extension String {
    
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
}
