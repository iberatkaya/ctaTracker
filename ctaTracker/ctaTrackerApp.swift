//
//  ctaTrackerApp.swift
//  ctaTracker
//
//  Created by Ibrahim Berat Kaya on 4/22/24.
//

import SwiftUI
import SwiftData

@main
struct ctaTrackerApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: BusRouteEntity.self)
    }
}
