//
//  ctaTrackerApp.swift
//  ctaTracker
//
//  Created by Ibrahim Berat Kaya on 4/22/24.
//

import SwiftUI
import SwiftData
import CoreLocation

@main
struct ctaTrackerApp: App {
    init() {
        UISegmentedControl.appearance().backgroundColor = .systemBlue.withAlphaComponent(0.08)
        UISegmentedControl.appearance().setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        UISegmentedControl.appearance().selectedSegmentTintColor = .systemBlue.withAlphaComponent(0.3)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.blue, .font : UIFont.systemFont(ofSize: 11)], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.systemBlue, .font : UIFont.systemFont(ofSize: 10)], for: .normal)
    }
    
    @StateObject var locationManager = LocationManager()
    @StateObject var viewModel = MainViewModel()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                Group {
                    MainMapView()
                        .tabItem {
                            Label("Map", systemImage: "map")
                        }
                    MainTrainView()
                        .tabItem {
                            Label("Train", systemImage: "train.side.front.car")
                        }
                    MainBusView()
                        .tabItem {
                            Label("Bus", systemImage: "bus.fill")
                        }
                }
                .toolbarBackground(Color(red: 242/255, green: 242/255, blue: 242/255), for: .tabBar)
                .toolbarBackground(.visible, for: .tabBar)
            }.task {
                await viewModel.loadJSON()
            }
        }
        .modelContainer(for: [TrainStopEntity.self, BusRouteEntity.self])
        .environmentObject(locationManager)
        .environmentObject(viewModel.trainStops)
    }
}
