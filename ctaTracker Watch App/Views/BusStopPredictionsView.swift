//
//  BusStopPredictionsView.swift
//  ctaTracker Watch App
//
//  Created by Ibrahim Berat Kaya on 5/21/24.
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
    let countdownTimer = Timer.publish(every: 30, on: .main, in: .common).autoconnect()
    let refreshTimer = Timer.publish(every: 90, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    HStack(spacing: 0) {
                        Text(busRoute.number).bold()
                        Text(" - " + busRoute.name)
                    }
                    .padding(.bottom, 2)
                    .font(.system(size: 15))
                    .scaledToFit()
                    .minimumScaleFactor(0.8)
                    Text(stop.name)
                        .font(.system(size: 13))
                }
                Spacer()
                
                Button(action: {
                    Task {
                        await viewModel.fetchPredictions()
                    }
                }, label: {
                    Image(systemName: "arrow.clockwise")
                        .font(.system(size: 14))
                })
                .buttonStyle(PlainButtonStyle())
                .frame(width: 28, height: 28)
                .background(.gray.opacity(0.4))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .padding(.horizontal, 6)
            
            Divider()
                .padding(.vertical, 4)
            
            if (viewModel.predictionsLoading) {
                ProgressView()
            } else if (viewModel.noScheduledService) {
                Text("No scheduled service. Please try another stop.")
                    .font(.system(size: 14))
                    .padding(.top, 16)
                    .padding(.horizontal, 4)
                    .multilineTextAlignment(.center)
            }
            else {
                VStack(spacing: 0) {
                    List {
                        Section {
                            ForEach(viewModel.busPredictions.predictions) { prediction in
                                HStack {
                                    Image(systemName: "circle.fill")
                                        .font(.system(size: 6)).foregroundColor(Color.white)
                                        .padding(.trailing, 4)
                                    HStack(spacing: 0) {
                                        if let pred = try? timestampDiffFromNowInMinutes(date: prediction.prediction, type: .bus, curDate: currentDate) {
                                            Text(pred > 0 ? (String(pred) + " mins left") : "Arriving soon")
                                                .font(.system(size: 11, weight: .regular)).padding(0)
                                                .onReceive(countdownTimer) { input in
                                                    currentDate = input
                                                }
                                        }
                                        Image(systemName: "arrow.forward")
                                            .font(.system(size: 11)).foregroundColor(Color.white).padding(.leading, 12).padding(.trailing, 4)
                                        Text(prediction.finalDestination)
                                            .font(.system(size: 11, weight: .regular)).padding(0)
                                            .foregroundStyle(.gray)
                                    }.padding(.vertical, 2)
                                    Spacer()
                                }
                            }
                        } header: {
                            Text("Predictions").font(.system(size: 14, weight: .semibold))
                                .padding(.bottom, 2)
                        }
                    }
                }
            }
        }
        .padding(.horizontal, 2)
        .onAppear(perform: {
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
