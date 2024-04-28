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
            TabView {
                ContentView()
                    .tabItem {
                        Label("Routes", systemImage: "bus.fill")
                    }
                
                TransitMapView()
                    .tabItem {
                        Label("Map", systemImage: "map.fill")
                    }
            }
        }
        .modelContainer(for: BusRouteEntity.self)
    }
}
