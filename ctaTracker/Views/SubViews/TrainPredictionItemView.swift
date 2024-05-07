//
//  TrainPredictionItemView.swift
//  ctaTracker
//
//  Created by Ibrahim Berat Kaya on 5/5/24.
//

import SwiftUI

struct TrainPredictionItemView: View {
    init(prediction: TrainStopPrediction) {
        self.prediction = prediction
    }
    
    var prediction: TrainStopPrediction
    
    var body: some View {
        HStack {
            Image(systemName: "circle.fill")
                .font(.system(size: 6)).foregroundColor(Color.black)
            HStack(spacing: 0) {
                if let pred = try? timestampDiffFromNowInMinutes(prediction.arrivalTime) {
                    Text(pred > 0 ? (String(pred)
                         + " minutes left") : "Arriving now").padding(0).font(.system(size: 16, weight: .regular))
                } else {
                    Text("Time couldn't be found")
                }
                Image(systemName: "arrow.forward")
                    .font(.system(size: 12)).foregroundColor(Color.black).padding(.leading, 12).padding(.trailing, 2)
                Text(prediction.destinationName)
                    .font(.system(size: 16, weight: .regular)).padding(0)
                    .foregroundStyle(.gray)
            }.padding(.vertical, 2)
            Spacer()
        }
    }
}

#Preview {
    TrainPredictionItemView(prediction: TrainStopPrediction(predictionTimestamp: "2024-09-13T22:13:08", stationID: "123", stopID: "123", stationName: "Howard", platformDescription: "123", runNumber: "123", routeName: "123", destinationID: "123", destinationName: "123", routeDirectionCode: "123", arrivalTime: "2024-09-13T22:13:08", isApproaching: true, isScheduled: false, isFaulty: false, isDelayed: true, location: nil, heading: nil))
}
