//
//  BusStopPredictionItemView.swift
//  ctaTracker
//
//  Created by Ibrahim Berat Kaya on 6/1/24.
//

import SwiftUI

struct BusStopPredictionItemView: View {
    internal init(prediction: BusStopPrediction, date: Date) {
        self.prediction = prediction
        self.date = date
    }
    
    let prediction: BusStopPrediction
    let date: Date
    
    var body: some View {
        HStack {
            Image(systemName: "circle.fill")
                .font(.system(size: 6)).foregroundColor(Color.black)
            HStack(spacing: 0) {
                if let pred = try? timestampDiffFromNowInMinutes(date: prediction.prediction, type: .bus, curDate: date) {
                    Text(pred > 0 ? (String(pred) + " mins left") : "Arriving soon")
                        .font(.system(size: 16, weight: .regular)).padding(0)
                }
                Image(systemName: "arrow.forward")
                    .font(.system(size: 13)).foregroundColor(Color.black).padding(.leading, 12).padding(.trailing, 4)
                Text(prediction.finalDestination)
                    .font(.system(size: 16, weight: .regular)).padding(0)
                    .foregroundStyle(.gray)
            }.padding(.vertical, 2)
            Spacer()
        }
    }
}

#Preview {
    BusStopPredictionItemView(prediction: BusStopPrediction(predictionTimestamp: "20240427", type: "A", stopName: "Michigan & Monroe", stopID: "18396", vehicleID: "4007", destinationFeetDistance: 3594, route: "151", routeDD: "151", routeDirection: "Southbound", finalDestination: "Union Station", prediction: "20240427 12:03", scheduledBlockID: "151 -510", scheduledTripID: "1007927", origtatripno: "254455166", delay: false, predictionMinutesLeft: "7", zone: ""), date: Date.now)
}
