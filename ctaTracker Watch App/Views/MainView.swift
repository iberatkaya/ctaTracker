//
//  MainView.swift
//  ctaTracker Watch App
//
//  Created by Ibrahim Berat Kaya on 5/19/24.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @EnvironmentObject var busRoutes: BusRoutes
    @Query(sort: \BusRouteEntity.number) var favoriteBusRoutes: [BusRouteEntity]
    @Query(sort: \TrainStopEntity.stationDescription) var favoriteTrainStops: [TrainStopEntity]
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        NavigationStack {
            List {
                if !favoriteBusRoutes.isEmpty {
                    NavigationLink(destination: { EmptyView() }, label: { Text("Favorite Bus Routes") })
                }
                if !favoriteTrainStops.isEmpty {
                    NavigationLink(destination: { EmptyView() }, label: { Text("Favorite Train Routes") })
                }
                NavigationLink(destination: { BusRoutesView() }, label: { Text("Bus Routes") })
                NavigationLink(destination: { TrainRoutesView() }, label: { Text("Train Routes") })
            }
        }
    }
}

#Preview {
    MainView()
}
