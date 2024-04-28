//
//  BusRoutesViewModel.swift
//  ctaTracker
//
//  Created by Ibrahim Berat Kaya on 4/28/24.
//

import Foundation
import SwiftUI

@MainActor 
class BusRoutesViewModel: ObservableObject {
    init(routes: [BusRoute]) {
        self.routes = routes
    }
    
    @Published var routes: [BusRoute]
}
