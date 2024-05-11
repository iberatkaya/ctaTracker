//
//  MainViewModel.swift
//  ctaTracker
//
//  Created by Ibrahim Berat Kaya on 4/28/24.
//

import Foundation
import SwiftUI

@MainActor 
class MainBusViewModel: ObservableObject {
    
    @Published var busRoutes: BusRoutes = BusRoutes(routes: [])
}
