//
//  TrainRoutesView.swift
//  ctaTracker Watch App
//
//  Created by Ibrahim Berat Kaya on 5/19/24.
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
                    columns: [GridItem(spacing: 12), GridItem(spacing: 0)],
                    spacing: 12
                ) {
                    if !favoriteTrainStops.isEmpty {
                        NavigationLink(destination: FavoriteTrainStopsView(), label: {
                            FavoriteItemView()
                        })
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    ForEach(TrainLine.allCases, id: \.rawValue) { route in
                        NavigationLink(destination: TrainDetailsView(train: route), label: {
                            TrainLineItemView(line: route)
                        })
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.top, 4)
                .padding(.horizontal, 4)
                Spacer()
            }
        }.padding(.horizontal, 2)
    }
}

#Preview {
    TrainRoutesView()
        .environmentObject(TrainStops(stops: []))
}
