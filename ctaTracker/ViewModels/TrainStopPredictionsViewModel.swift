//
//  TrainStopPredictionsViewModel.swift
//  ctaTracker
//
//  Created by Ibrahim Berat Kaya on 5/3/24.
//

import Foundation
import SwiftUI
import SwiftData

@MainActor
class TrainStopPredictionsViewModel: ObservableObject {
    init(trainLine: TrainLine, trainStop: TrainStop, trainPredictions: TrainStopPredictions? = nil) {
        self.trainLine = trainLine
        self.trainStop = trainStop
        self.trainPredictions = trainPredictions ?? TrainStopPredictions(predictions: [])
    }
    
    var trainLine: TrainLine
    var trainStop: TrainStop
    
    @Published var trainPredictions: TrainStopPredictions
    @Published var predictionsLoading = false
    let repo = TrainRepository()
    
    func fetchPredictions(getAllStops: Bool = false) async {
        predictionsLoading = true
        guard let data = try? await repo.getArrivals(mapID: String(trainStop.mapID), line: getAllStops ? nil : trainLine) else {
            predictionsLoading = false
            return
        }
        let predictions = try? TrainStopPredictions.fromDataObject(data: data)
        trainPredictions.predictions = predictions?.predictions ?? []
        predictionsLoading = false
    }
}
