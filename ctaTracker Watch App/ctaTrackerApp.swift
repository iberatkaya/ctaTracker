//
//  ctaTrackerApp.swift
//  ctaTracker Watch App
//
//  Created by Ibrahim Berat Kaya on 4/22/24.
//

import SwiftUI

@main
struct ctaTracker_Watch_AppApp: App {
    
    @StateObject var locationManager = LocationManager()
    @StateObject var viewModel = MainViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .task {
                    if viewModel.trainStops.stops.isEmpty {
                        await viewModel.loadJSON()
                    }
                }
        }
        .environmentObject(viewModel.trainStops)
        .modelContainer(for: [TrainStopEntity.self, BusRouteEntity.self])
        .environmentObject(locationManager)
        .environmentObject(viewModel.trainStops)
    }
}
