//
//  BusStopPredictionsView.swift
//  ctaTracker
//
//  Created by Ibrahim Berat Kaya on 4/27/24.
//

import SwiftUI

struct BusStopPredictionsView: View {
    let busRoute: BusRoute
    let stop: BusRouteStop
    @StateObject var busPredictions: BusStopPredictions = BusStopPredictions(predictions: [])
    //    @Query(sort: \BusRouteEntity.number) var favoriteBusRoutes: [BusRouteEntity]
    @Environment(\.modelContext) var modelContext
    @State var predictionsLoading = false
    
    var body: some View {
        ScrollView {
            VStack {
                Text(busRoute.number).font(.system(size: 32, weight: .semibold))
                Text("Route: " + busRoute.name)
                    .font(.system(size: 15, weight: .semibold))
                Text("Stop: " + stop.name)
                    .font(.system(size: 13))
            }
            .padding(.horizontal, 32)
            .padding(.vertical, 12)
            .overlay(
                RoundedRectangle(cornerRadius: 32)
                    .stroke(.black, lineWidth: 2)
            )
            
            Divider().padding(EdgeInsets(top: 4, leading: 0, bottom: 12, trailing: 0))
            
            if (predictionsLoading) {
                ProgressView()
            } else {
                HStack{
                    VStack(spacing: 0) {
                        ForEach(busPredictions.predictions) { prediction in
                            HStack {
                                Image(systemName: "circle.fill")
                                    .font(.system(size: 6)).foregroundColor(Color.black)
                                HStack(spacing: 0) {
                                    Text(prediction.predictionMinutesLeft + " mins left - ")
                                        .font(.system(size: 16, weight: .regular)).padding(0)
                                    Text(prediction.finalDestination)
                                        .font(.system(size: 16, weight: .regular)).padding(0)
                                        .foregroundStyle(.gray)
                                }.padding(.vertical, 2)
                                Spacer()
                            }
                        }
                    }
                    Spacer()
                }.padding(.horizontal, 16)
            }
        }
        .task {
            guard !isPreviewBuilder() else { return }
            predictionsLoading = true
            let repo = BusRepository()
            guard let res = await repo.getRouteStopPredictions(routeNumber: busRoute.number, stopID: stop.stopID) else { return }
            busPredictions.predictions = BusStopPredictions.fromDataObject(data: res).predictions
            predictionsLoading = false
        }
    }
}

#Preview {
    BusStopPredictionsView(busRoute: BusRoute(number: "151", name: "Sheridan", color: "#f0f"), stop: BusRouteStop(stopID: "123", name: "Clark", lat: 15, lon: 14), busPredictions: BusStopPredictions(predictions: [BusStopPrediction(predictionTimestamp: "20240427", type: "A", stopName: "Michigan & Monroe", stopID: "18396", vehicleID: "4007", destinationFeetDistance: 3594, route: "151", routeDD: "151", routeDirection: "Southbound", finalDestination: "Union Station", prediction: "20240427 12:03", scheduledBlockID: "151 -510", scheduledTripID: "1007927", origtatripno: "254455166", delay: false, predictionMinutesLeft: "7", zone: "")]))
}
