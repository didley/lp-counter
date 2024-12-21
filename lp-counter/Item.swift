//
//  Item.swift
//  lp-counter
//
//  Created by Dylan Lamont on 21/12/2024.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
