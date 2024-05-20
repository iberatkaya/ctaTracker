//
//  TrainDetailsView.swift
//  ctaTracker Watch App
//
//  Created by Ibrahim Berat Kaya on 5/19/24.
//

import SwiftUI
import SwiftData

struct TrainDetailsView: View {
    internal init(train: TrainLine) {
        self.train = train
    }
    
    let train: TrainLine
    @EnvironmentObject var trainStops: TrainStops
    @Query(sort: \TrainStopEntity.stationDescription) var favoriteTrainStops: [TrainStopEntity]
    @Environment(\.modelContext) var modelContext

    var body: some View {
        VStack {
            Text("\(mapTrainLineToName(train)) Line").font(.system(size: 20, weight: .semibold))
                .scaledToFit()
                .minimumScaleFactor(0.8)
                .foregroundColor(mapTrainLineToColor(train))
                .padding(.horizontal, 4)
            
                
            List {
                ForEach(Array(lineStopsOrdering[mapTrainLineToKey(train)]!.enumerated()), id: \.offset) { index, stopID in
                    let stop = trainStops.stops.first { $0.mapID == stopID }
                    
                    if let stop {
                        NavigationLink(destination: TrainStopPredictionsView(train: train, trainStop: stop), label: {
                            TrainStopItemView(train: train, stop: stop, isFaved: favoriteTrainStops.map({ Int($0.mapID) }).contains(stop.mapID), onSavePress: saveItem, onDeletePress: removeItem)
                        })
                    }
                    EmptyView()
                }
            }
        }
    }
    
    func saveItem(_ item: TrainStop) {
        let entity = item.toDataModel(selectedLine: train)
        modelContext.insert(entity)
        try? modelContext.save()
    }
    
    func removeItem(_ item: TrainStop) {
        let entity = favoriteTrainStops.first(where: { $0.mapID == item.mapID })
        if let entity {
            modelContext.delete(entity)
        }
    }
}

#Preview {
    TrainDetailsView(train: .red)
        .environmentObject(TrainStops(stops: [TrainStop(stopID: 123, directionID: "123", stopName: "Test", stationName: "Test", stationDescription: "Test (Red Line)", mapID: 123, lines: [.red], location: CLLocationCoordinate2D(latitude: 12, longitude: 12))]))
}
