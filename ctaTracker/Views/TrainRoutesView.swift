//
//  TrainRoutesView.swift
//  ctaTracker
//
//  Created by Ibrahim Berat Kaya on 4/30/24.
//

import SwiftUI
import SwiftData

struct TrainRoutesView: View {
    @Environment(\.modelContext) var modelContext
    @EnvironmentObject var trainStops: TrainStops
    @Query(sort: \TrainStopEntity.stationDescription) var favoriteTrainStops: [TrainStopEntity]
    
    var body: some View {
        VStack {
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
                Section(header: Text("All Train Lines")) {
                    ForEach(TrainLine.allCases, id: \.rawValue) { route in
                        NavigationLink(destination: TrainDetailsView(train: route), label: {
                            TrainLineItemView(line: route)
                        })
                    }
                }
            }
        }
        .navigationBarTitle("CTA Tracker", displayMode: .inline)
    }
    
    func removeItem(_ item: TrainStop) {
        let entity = favoriteTrainStops.first(where: { $0.mapID == item.mapID })
        if let entity {
            modelContext.delete(entity)
        }
    }
}

#Preview {
    TrainRoutesView()
        .environmentObject(BusRoutes(routes: [BusRoute(number: "151", name: "Sheridan", color: "#f0f")]))
}
