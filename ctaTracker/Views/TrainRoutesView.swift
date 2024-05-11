//
//  TrainRoutesView.swift
//  ctaTracker
//
//  Created by Ibrahim Berat Kaya on 4/30/24.
//

import SwiftUI
import SwiftData

struct TrainRoutesView: View {
    @EnvironmentObject var trainStops: TrainStops
    @Query(sort: \TrainStopEntity.stationDescription) var favoriteTrainStops: [TrainStopEntity]
    
    var body: some View {
        VStack {
            Divider()
            ScrollView {
                LazyVGrid(
                    columns: [GridItem(spacing: 20), GridItem(spacing: 0)],
                    spacing: 20
                ) {
                    if !trainStops.stops.isEmpty {
                        NavigationLink(destination: FavoriteTrainStopsView(), label: {
                            FavoriteItemView()
                        })
                    }
                    
                    ForEach(TrainLine.allCases, id: \.rawValue) { route in
                        NavigationLink(destination: TrainDetailsView(train: route), label: {
                            TrainLineItemView(line: route)
                        })
                    }
                }
                .padding(.top, 12)
                .padding(.horizontal, 24)
                Spacer()
            }
            .navigationBarTitle("CTA Tracker", displayMode: .inline)
        }
        
    }
}

#Preview {
    TrainRoutesView()
        .environmentObject(BusRoutes(routes: [BusRoute(number: "151", name: "Sheridan", color: "#f0f")]))
        .environmentObject(TrainStops(stops: []))
}
