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
    
    init() {
        UISegmentedControl.appearance().backgroundColor = .systemBlue.withAlphaComponent(0.08)
        UISegmentedControl.appearance().setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        UISegmentedControl.appearance().selectedSegmentTintColor = .systemBlue.withAlphaComponent(0.3)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.blue, .font : UIFont.systemFont(ofSize: 11)], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.systemBlue, .font : UIFont.systemFont(ofSize: 10)], for: .normal)
    }
    
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
