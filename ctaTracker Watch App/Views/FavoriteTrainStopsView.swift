//
//  FavoriteTrainStopsView.swift
//  ctaTracker Watch App
//
//  Created by Ibrahim Berat Kaya on 5/21/24.
//

import SwiftUI
import SwiftData

struct FavoriteTrainStopsView: View {
    @Environment(\.modelContext) var modelContext
    @EnvironmentObject var trainStops: TrainStops
    @Query(sort: \TrainStopEntity.stationDescription) var favoriteTrainStops: [TrainStopEntity]
    
    var body: some View {
        List {
            if (!favoriteTrainStops.isEmpty && !trainStops.stops.isEmpty) {
                Section(header: Text("Favorite Train Stops")) {
                    ForEach(favoriteTrainStops, id: \.mapID) { route in
                        let stop = trainStops.stops.first { $0.mapID == route.mapID }
                        
                        if let stop, let line = TrainLine(rawValue: route.trainLine) {
                            NavigationLink(destination: TrainStopPredictionsView(train: line, trainStop: stop), label: {
                                TrainStopItemView(train: line, stop: stop, isFaved: true, onSavePress: { _ in }, onDeletePress: removeItem, title: stop.stationName + " - \(mapTrainLineToName(line)) Line")
                            })
                        }
                        EmptyView()
                    }
                }
            }
        }.padding(.horizontal, 2)
    }
    
    func removeItem(_ item: TrainStop) {
        let entity = favoriteTrainStops.first(where: { $0.mapID == item.mapID })
        if let entity {
            modelContext.delete(entity)
        }
    }
}

#Preview {
    FavoriteTrainStopsView()
}
