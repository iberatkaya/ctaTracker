//
//  TrainStopPredictionsView.swift
//  ctaTracker
//
//  Created by Ibrahim Berat Kaya on 5/3/24.
//

import SwiftUI
import CoreLocation

struct TrainStopPredictionsView: View {
    init(train: TrainLine, trainStop: TrainStop, viewModel: TrainStopPredictionsViewModel? = nil) {
        self.train = train
        self.trainStop = trainStop
        self.viewModel = viewModel ?? TrainStopPredictionsViewModel(trainLine: train, trainStop: trainStop)
    }
    
    let train: TrainLine
    let trainStop: TrainStop
    @ObservedObject var viewModel: TrainStopPredictionsViewModel
    @EnvironmentObject var trainStops: TrainStops

    var body: some View {
        VStack(spacing: 0) {
            Text(trainStop.stationName).padding(.bottom, 8).padding(.top, 4).font(.system(size: 19).bold())
            Text(mapTrainLineToName(train) + " Line").font(.system(size: 15)).padding(.bottom, 12).foregroundStyle(.gray)
            List {
                ForEach(getUniqueItemsFromArray(viewModel.trainPredictions.predictions.map({ $0.destinationName })), id: \.self) { dir in
                    Section(dir) {
                        ForEach(Array(viewModel.trainPredictions.predictions.filter{ $0.destinationName == dir }.enumerated()), id: \.offset) { index, prediction in
                                TrainPredictionItemView(prediction: prediction)
                            }
                        }
                }
            }
            Spacer()
        }
        .task {
            await viewModel.fetchPredictions()
        }
    }
}

#Preview {
    TrainStopPredictionsView(
        train: .red,
        trainStop: TrainStop(stopID: 123, directionID: "123", stopName: "Howard", stationName: "Howard", stationDescription: "Howard", mapID: 123, lines: [.red], location: CLLocationCoordinate2D(latitude: 1, longitude: 1)),
        viewModel: TrainStopPredictionsViewModel(
            trainLine: .red, trainStop: TrainStop(stopID: 123, directionID: "123", stopName: "Howard", stationName: "Howard", stationDescription: "Howard", mapID: 123, lines: [.red], location: CLLocationCoordinate2D(latitude: 1, longitude: 1)), trainPredictions: TrainStopPredictions(predictions: [TrainStopPrediction(predictionTimestamp: "2024-09-13T22:13:08", stationID: "123", stopID: "123", stationName: "Howard", platformDescription: "123", runNumber: "123", routeName: "123", destinationID: "123", destinationName: "123", routeDirectionCode: "123", arrivalTime: "2024-09-13T22:13:08", isApproaching: true, isScheduled: false, isFaulty: false, isDelayed: true, location: nil, heading: nil), TrainStopPrediction(predictionTimestamp: "2024-09-13T22:13:08", stationID: "123", stopID: "123", stationName: "Howard", platformDescription: "123", runNumber: "123", routeName: "123", destinationID: "123", destinationName: "123", routeDirectionCode: "123", arrivalTime: "2024-09-15T22:13:08", isApproaching: true, isScheduled: false, isFaulty: false, isDelayed: true, location: nil, heading: nil), TrainStopPrediction(predictionTimestamp: "2024-09-14T22:13:08", stationID: "123", stopID: "123", stationName: "Howard", platformDescription: "123", runNumber: "123", routeName: "123", destinationID: "456", destinationName: "456", routeDirectionCode: "456", arrivalTime: "2024-09-16T22:13:08", isApproaching: true, isScheduled: false, isFaulty: false, isDelayed: true, location: nil, heading: nil)])))
}
