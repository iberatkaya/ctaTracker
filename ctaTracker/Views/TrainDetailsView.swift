//
//  TrainDetailsView.swift
//  ctaTracker
//
//  Created by Ibrahim Berat Kaya on 5/3/24.
//

import SwiftUI

struct TrainDetailsView: View {
    internal init(train: TrainLine) {
        self.train = train
    }
    
    let train: TrainLine
    @EnvironmentObject var trainStops: TrainStops
    
    var body: some View {
        List {
            Section(header: Text(mapTrainLineToName(train) + " Line Stops")) {
                ForEach(Array(lineStopsOrdering[mapTrainLineToKey(train)]!.enumerated()), id: \.offset) { index, stopID in
                    let stop = trainStops.stops.first { $0.mapID == stopID }
                    NavigationLink(destination: TrainStopPredictionsView(train: train, trainStop: stop!), label: {
                        Text(stop?.stationDescription ?? "")
                    })
                }
            }
        }
    }
}

#Preview {
    TrainDetailsView(train: .red)
}
