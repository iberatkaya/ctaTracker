//
//  BusRouteEntity.swift
//  ctaTracker
//
//  Created by Ibrahim Berat Kaya on 4/26/24.
//
//

import Foundation
import SwiftData


@Model public class BusRouteEntity {
    init(color: String, name: String, number: String) {
        self.color = color
        self.name = name
        self.number = number
    }
    
    var color: String
    var name: String
    var number: String
    
    
}
