//
//  TrainStopPredictionsView.swift
//  ctaTracker
//
//  Created by Ibrahim Berat Kaya on 5/3/24.
//

import SwiftUI
import CoreLocation
import SwiftData

struct TrainStopPredictionsView: View {
    init(train: TrainLine, trainStop: TrainStop, viewModel: TrainStopPredictionsViewModel? = nil) {
        self.train = train
        self.trainStop = trainStop
        self._viewModel = StateObject(wrappedValue: viewModel ?? TrainStopPredictionsViewModel(trainLine: train, trainStop: trainStop))
    }

    let train: TrainLine
    let trainStop: TrainStop
    @StateObject var viewModel: TrainStopPredictionsViewModel
    @EnvironmentObject var trainStops: TrainStops
    @Query(sort: \TrainStopEntity.stationDescription) var favoriteTrainStops: [TrainStopEntity]
    @Environment(\.modelContext) var modelContext

    var body: some View {
        VStack(spacing: 0) {
            VStack {
                Text(trainStop.stationName).padding(.bottom, 8).padding(.top, 4).font(.system(size: 19).bold())
                Text(mapTrainLineToName(train) + " Line").font(.system(size: 15)).padding(.bottom, 12).foregroundStyle(.gray)
            }
            .padding(.bottom, -18)
            HStack {
                Spacer()
                if (favoriteTrainStops.contains(where: { $0.stopID == trainStop.stopID })) {
                    Button(action: {
                      removeItem(trainStop)
                    }) {
                        Image(systemName: "star.fill")
                            .font(.system(size: 16, weight: .light)).foregroundColor(Color.yellow)
                    }
                } else {
                    Button(action: {
                      saveItem(trainStop)
                    }) {
                        Image(systemName: "star")
                            .font(.system(size: 16, weight: .light)).foregroundColor(Color.gray)
                    }
                }
            }.offset(x: -16, y: -28)
            
            List {
                ForEach(getUniqueItemsFromArray(viewModel.trainPredictions.predictions.map({ $0.destinationName })).sorted(), id: \.self) { dir in
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
    TrainStopPredictionsView(
        train: .red,
        trainStop: TrainStop(stopID: 123, directionID: "123", stopName: "Howard", stationName: "Howard", stationDescription: "Howard", mapID: 123, lines: [.red], location: CLLocationCoordinate2D(latitude: 1, longitude: 1)),
        viewModel: TrainStopPredictionsViewModel(
            trainLine: .red, trainStop: TrainStop(stopID: 123, directionID: "123", stopName: "Howard", stationName: "Howard", stationDescription: "Howard", mapID: 123, lines: [.red], location: CLLocationCoordinate2D(latitude: 1, longitude: 1)), trainPredictions: TrainStopPredictions(predictions: [TrainStopPrediction(predictionTimestamp: "2024-09-13T22:13:08", stationID: "123", stopID: "123", stationName: "Howard", platformDescription: "123", runNumber: "123", routeName: "123", destinationID: "123", destinationName: "123", routeDirectionCode: "123", arrivalTime: "2024-09-13T22:13:08", isApproaching: true, isScheduled: false, isFaulty: false, isDelayed: true, location: nil, heading: nil), TrainStopPrediction(predictionTimestamp: "2024-09-13T22:13:08", stationID: "123", stopID: "123", stationName: "Howard", platformDescription: "123", runNumber: "123", routeName: "123", destinationID: "123", destinationName: "123", routeDirectionCode: "123", arrivalTime: "2024-09-15T22:13:08", isApproaching: true, isScheduled: false, isFaulty: false, isDelayed: true, location: nil, heading: nil), TrainStopPrediction(predictionTimestamp: "2024-09-14T22:13:08", stationID: "123", stopID: "123", stationName: "Howard", platformDescription: "123", runNumber: "123", routeName: "123", destinationID: "456", destinationName: "456", routeDirectionCode: "456", arrivalTime: "2024-09-16T22:13:08", isApproaching: true, isScheduled: false, isFaulty: false, isDelayed: true, location: nil, heading: nil)])))
}
