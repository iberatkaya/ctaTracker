//
//  TrainDetailsView.swift
//  ctaTracker
//
//  Created by Ibrahim Berat Kaya on 5/3/24.
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
    @State var displayOptions = ["Map", "List"]
    @State var mapViewEnabledIndex = 0

    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .center, spacing: 0) {
                    Text("\(mapTrainLineToName(train)) Line").font(.system(size: 20, weight: .semibold))
                        .scaledToFit()
                        .minimumScaleFactor(0.8)
                        .foregroundColor(mapTrainLineToColor(train))
                }
                
                Spacer()
                
                VStack {
                    Picker("Direction", selection: $mapViewEnabledIndex) {
                        ForEach(0..<displayOptions.count, id: \.self) { index in
                            Text(displayOptions[index])
                                .tag(index)
                                .font(.system(size: 14))
                        }
                    }
                    .pickerStyle(.segmented)
                }
                .frame(width: 200)
                .padding(.bottom, 4)
                .padding(.top, 8)
            }.padding(.horizontal, 24)
            
            
            TabView(selection: $mapViewEnabledIndex) {
                TrainTransitMapView(train: train, stops: TrainStops(stops:   Array(lineStopsOrdering[mapTrainLineToKey(train)]!.enumerated()).map({ index, stopID in
                    return trainStops.stops.first { $0.mapID == stopID }!
                }))).tag(0)
                
                List {
                    Section(header: Text(mapTrainLineToName(train) + " Line Stops")) {
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
                }.tag(1)
            }.tabViewStyle(.page(indexDisplayMode: .never))
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
}
