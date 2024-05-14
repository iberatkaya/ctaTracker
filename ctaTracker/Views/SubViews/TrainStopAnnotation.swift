//
//  TrainStopAnnotation.swift
//  ctaTracker
//
//  Created by Ibrahim Berat Kaya on 5/11/24.
//

import SwiftUI
import MapKit

struct TrainStopAnnotation: MapContent {
    
    let trains: [TrainLine]
    let stop: TrainStop
    @State var showingPopover = false
    @State private var path = NavigationPath()
    @State var selectedTrain: TrainLine? = nil

    var body: some MapContent {
        Annotation(stop.stationName, coordinate: stop.location) {
            if trains.count > 1 {
                Menu {
                    ForEach(trains, id: \.rawValue) { train in
                        NavigationLink(destination: { TrainStopPredictionsView(train: train, trainStop: stop) }) {
                            Text("\(mapTrainLineToName(train)) Line")
                        }
                    }
                } label: {
                    ZStack {
                        Circle()
                            .foregroundStyle(mapTrainLineToColor(trains.first!).opacity(0.25))
                            .frame(width: 28, height: 28)
                        
                        Image(systemName: "mappin").foregroundColor(mapTrainLineToColor(trains.first!)).font(.system(size: 16)).brightness(-0.2)
                    }
                }
            } else {
                NavigationLink(destination: { TrainStopPredictionsView(train: trains.first!, trainStop: stop) }) {
                    ZStack {
                        Circle()
                            .foregroundStyle(mapTrainLineToColor(trains.first!).opacity(0.25))
                            .frame(width: 28, height: 28)
                        
                        Image(systemName: "mappin").foregroundColor(mapTrainLineToColor(trains.first!)).font(.system(size: 16)).brightness(-0.2)
                    }
                }
            }
        }
    }
}

#Preview {
    Map {
        TrainStopAnnotation(trains: [.blue], stop: TrainStop(stopID: 123, directionID: "123", stopName: "Test", stationName: "Test", stationDescription: "Test (Red Line)", mapID: 123, lines: [.blue], location: CLLocationCoordinate2D(latitude: 12, longitude: 12)))
    }
}
