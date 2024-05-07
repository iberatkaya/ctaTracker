//
//  TrainStopItemView.swift
//  ctaTracker
//
//  Created by Ibrahim Berat Kaya on 5/6/24.
//

import SwiftUI
import CoreLocation

struct TrainStopItemView: View {
    init(train: TrainLine, stop: TrainStop, isFaved: Bool, onSavePress: @escaping (TrainStop) -> Void, onDeletePress: @escaping (TrainStop) -> Void, title: String? = nil) {
        self.train = train
        self.stop = stop
        self.isFaved = isFaved
        self.onSavePress = onSavePress
        self.onDeletePress = onDeletePress
        self.title = title
    }
    
    let train: TrainLine
    let stop: TrainStop
    let isFaved: Bool
    let onSavePress: (_ stop: TrainStop) -> Void
    let onDeletePress: (_ stop: TrainStop) -> Void
    let title: String?
    
    var body: some View {
        HStack {
            if (isFaved) {
                Image(systemName: "star.fill")
                    .font(.system(size: 16, weight: .light)).foregroundColor(Color.yellow)
            }
            Text(title ?? stop.stationName)
                .swipeActions {
                    if (isFaved) {
                        Button("Delete") {
                            onDeletePress(stop)
                        }
                        .tint(.red)
                    } else {
                        Button("Save") {
                            onSavePress(stop)
                        }
                        .tint(.yellow)
                    }
                }
        }
    }
}

#Preview {
    TrainStopItemView(train: .red, stop: TrainStop(stopID: 123, directionID: "123", stopName: "Test", stationName: "Test", stationDescription: "Test (Red Line)", mapID: 123, lines: [.red], location: CLLocationCoordinate2D(latitude: 12, longitude: 12)), isFaved: true, onSavePress: {_ in }, onDeletePress: {_ in })
}
