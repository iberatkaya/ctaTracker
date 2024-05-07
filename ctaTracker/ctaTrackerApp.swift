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
                MainTrainView()
                    .tabItem {
                        Label("Train", systemImage: "train.side.front.car")
                    }
                MainBusView()
                    .tabItem {
                        Label("Bus", systemImage: "bus.fill")
                    }
            }
        }
        .modelContainer(for: [TrainStopEntity.self, BusRouteEntity.self])
    }
}
