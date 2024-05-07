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
    
    @ObservedObject var viewModel: BusStopPredictionsViewModel
    
    init(busRoute: BusRoute, stop: BusRouteStop, viewModel: BusStopPredictionsViewModel? = nil) {
        self.busRoute = busRoute
        self.stop = stop
        self.viewModel = viewModel ?? BusStopPredictionsViewModel(busRoute: busRoute, stop: stop)
    }
    
    @State private var currentDate = Date.now
    let timer = Timer.publish(every: 30, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
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
            
            if (viewModel.predictionsLoading) {
                ProgressView()
            } else if (viewModel.noScheduledService) {
                Text("No scheduled service. Please try another stop.")
                    .font(.system(size: 14))
                    .padding(.horizontal, 16)
                    .multilineTextAlignment(.center)
            }
            else {
                HStack{
                    VStack(spacing: 0) {
                        Section("Predictions") {
                            ForEach(viewModel.busPredictions.predictions) { prediction in
                                
                                HStack {
                                    Image(systemName: "circle.fill")
                                        .font(.system(size: 6)).foregroundColor(Color.black)
                                    HStack(spacing: 0) {
                                        if let pred = try? timestampDiffFromNowInMinutes(date: prediction.prediction, type: .bus, curDate: currentDate) {
                                            Text(String(pred) + " mins left")
                                                .font(.system(size: 16, weight: .regular)).padding(0)
                                                .onReceive(timer) { input in
                                                    currentDate = input
                                                }
                                        }
                                        Image(systemName: "arrow.forward")
                                            .font(.system(size: 12)).foregroundColor(Color.black).padding(.leading, 12).padding(.trailing, 2)
                                        Text(prediction.finalDestination)
                                            .font(.system(size: 16, weight: .regular)).padding(0)
                                            .foregroundStyle(.gray)
                                    }.padding(.vertical, 2)
                                    Spacer()
                                }
                            }
                        }.headerProminence(.increased)
                    }
                }.padding(.horizontal, 16)
                
            }
            Spacer()
        }
        .onAppear(perform: {
            viewModel.busRoute = busRoute
            viewModel.stop = stop
            Task {
                guard !isPreviewBuilder() else { return }
                if (viewModel.didFetchData) { return }
                await viewModel.fetchPredictions()
            }
        })
    }
}

#Preview {
    BusStopPredictionsView(busRoute: BusRoute(number: "151", name: "Sheridan", color: "#f0f"), stop: BusRouteStop(stopID: "123", name: "Clark", lat: 15, lon: 14), viewModel: BusStopPredictionsViewModel(busRoute: BusRoute(number: "151", name: "Sheridan", color: "#f0f"), stop: BusRouteStop(stopID: "123", name: "Clark", lat: 15, lon: 14), busPredictions: BusStopPredictions(predictions: [BusStopPrediction(predictionTimestamp: "20240427", type: "A", stopName: "Michigan & Monroe", stopID: "18396", vehicleID: "4007", destinationFeetDistance: 3594, route: "151", routeDD: "151", routeDirection: "Southbound", finalDestination: "Union Station", prediction: "20240427 12:03", scheduledBlockID: "151 -510", scheduledTripID: "1007927", origtatripno: "254455166", delay: false, predictionMinutesLeft: "7", zone: "")])))
    
}
