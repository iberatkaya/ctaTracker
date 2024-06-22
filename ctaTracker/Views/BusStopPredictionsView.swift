//
//  BusStopPredictionsView.swift
//  ctaTracker
//
//  Created by Ibrahim Berat Kaya on 4/27/24.
//

import SwiftUI
import ActivityIndicatorView

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
    let countdownTimer = Timer.publish(every: 30, on: .main, in: .common).autoconnect()
    let refreshTimer = Timer.publish(every: 90, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    HStack(spacing: 0) {
                        Text(busRoute.number).bold()
                        Text(" - " + busRoute.name)
                    }.padding(.bottom, 6)
                    .font(.system(size: 18))
                    .scaledToFit()
                    .minimumScaleFactor(0.8)
                    Text(stop.name)
                        .font(.system(size: 15))
                }
                Spacer()
            }.padding(.horizontal, 24)
            .padding(.bottom, 12)
            .background(Color.white)
            
            if (viewModel.predictionsLoading) {
                ActivityIndicatorView(isVisible: $viewModel.predictionsLoading, type: .growingArc(.blue, lineWidth: 3))
                         .frame(width: 54.0, height: 54.0)
                         .padding(.top, 24)
            } else if (viewModel.noScheduledService) {
                Text("No scheduled service. Please try another stop.")
                    .font(.system(size: 14))
                    .padding(.top, 16)
                    .padding(.horizontal, 16)
                    .multilineTextAlignment(.center)
            }
            else {
                VStack(spacing: 0) {
                    List {
                        Section {
                            ForEach(viewModel.busPredictions.predictions) { prediction in
                                BusStopPredictionItemView(prediction: prediction, date: currentDate)
                                    .onReceive(countdownTimer) { input in
                                        currentDate = input
                                    }
                            }
                        } header: {
                            Text("Predictions").font(.system(size: 16, weight: .semibold))
                                .padding(.bottom, 4)
                        }
                    }.refreshable {
                        Task {
                            await viewModel.fetchPredictions()
                        }
                    }
                }
            }
            Spacer()
        }
        .background(Color(UIColor.systemGray6))
        .onAppear(perform: {
            print("on appear")
            viewModel.busRoute = busRoute
            viewModel.stop = stop
            Task {
                guard !isPreviewBuilder() else { return }
                if (viewModel.didFetchDataOnce) { return }
                await viewModel.fetchPredictions()
            }
        })
        .onReceive(refreshTimer) { _ in
            Task {
                guard !isPreviewBuilder() else { return }
                await viewModel.fetchPredictions()
            }
        }
    }
}

#Preview {
    BusStopPredictionsView(busRoute: BusRoute(number: "151", name: "Sheridan", color: "#f0f"), stop: BusRouteStop(stopID: "123", name: "Clark", lat: 15, lon: 14), viewModel: BusStopPredictionsViewModel(busRoute: BusRoute(number: "151", name: "Sheridan", color: "#f0f"), stop: BusRouteStop(stopID: "123", name: "Clark", lat: 15, lon: 14), busPredictions: BusStopPredictions(predictions: [BusStopPrediction(predictionTimestamp: "20240427", type: "A", stopName: "Michigan & Monroe", stopID: "18396", vehicleID: "4007", destinationFeetDistance: 3594, route: "151", routeDD: "151", routeDirection: "Southbound", finalDestination: "Union Station", prediction: "20240427 12:03", scheduledBlockID: "151 -510", scheduledTripID: "1007927", origtatripno: "254455166", delay: false, predictionMinutesLeft: "7", zone: "")])))
    
}
