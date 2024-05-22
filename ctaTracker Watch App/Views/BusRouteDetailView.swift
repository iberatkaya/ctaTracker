//
//  BusRouteDetailView.swift
//  ctaTracker Watch App
//
//  Created by Ibrahim Berat Kaya on 5/21/24.
//

import SwiftUI
import SwiftData

struct BusRouteDetailView: View {
    @State var busRoute: BusRoute
    @StateObject var viewModel: BusRouteDetailsViewModel
    @State var directionIndex: Int = 0
    @State var mapViewEnabledIndex = 0

    init(busRoute: BusRoute, viewModel: BusRouteDetailsViewModel? = nil) {
        self.busRoute = busRoute
        self._viewModel = StateObject(wrappedValue:viewModel ?? BusRouteDetailsViewModel(busRoute: busRoute))
    }

    var body: some View {
        VStack(spacing: 0) {
            if (viewModel.stopsLoading) {
                ProgressView()
            } else {
                VStack(spacing: 0) {
                    List {
                        Section(content: {
                            HStack(spacing: 0) {
                                Spacer()
                                VStack(spacing: 0) {
                                    Text(busRoute.number).bold()
                                    Text(busRoute.name).scaledToFit().minimumScaleFactor(0.6)
                                }
                                Spacer()
                                
                                Divider().padding(.horizontal, 6)
                                
                                Picker(selection: $directionIndex, label:
                                        Text("Direction").font(.system(size: 12))) {
                                    ForEach(0..<viewModel.busDirections.directions.count, id: \.self) { index in
                                        Text(viewModel.busDirections.directions[index])
                                            .tag(index)
                                            .font(.system(size: 12))
                                            .scaledToFit()
                                            .minimumScaleFactor(0.7)
                                    }
                                }
                                .frame(width: 56)
                                .pickerStyle(.navigationLink)
                                .onChange(of: directionIndex) {
                                    Task {
                                        await self.viewModel.fetchStops(direction: self.viewModel.busDirections.directions[directionIndex])
                                    }
                                }
                            }.padding(.horizontal, -4)
                        })

                        if let pattern = viewModel.busPatterns.patterns.first(where: { pattern in
                            return pattern.routeDirection == viewModel.busDirections.directions[directionIndex]
                        }) {
                            ForEach(orderBusStops(viewModel.busRouteStops.stops, pattern)) { stop in
                                NavigationLink(destination: BusStopPredictionsView(busRoute: viewModel.busRoute, stop: stop), label: {
                                    HStack(spacing: 0) {
                                        Image(systemName: "circle.fill")
                                            .font(.system(size: 6)).foregroundColor(Color.black)
                                            .padding(.trailing, 8)
                                        Text(stop.name)
                                            .font(.system(size: 16, weight: .regular))
                                            .padding(.vertical, 2)
                                        Spacer()
                                    }
                                }).padding(.vertical, 4)
                            }
                        }
                    }
                }
            }
        }.task({
            guard !isPreviewBuilder() else { return }
            if (viewModel.didFetchDirectionData) { return }
            await viewModel.fetchDirections()
            if (viewModel.didFetchStopsData) { return }
            await viewModel.fetchStops(direction: viewModel.busDirections.directions[self.directionIndex])
            await viewModel.fetchPatterns()
        })
        .padding(.top, 8)
        .padding(.horizontal, 2)
    }
}

#Preview {
    var viewModel = BusRouteDetailsViewModel(busRoute: BusRoute(number: "151", name: "Jackson Park Express", color: "#f0f"), directions: BusDirections(directions: ["Northbound", "Southbound"]))
    viewModel.busRouteStops = BusRouteStops(stops: [BusRouteStop(stopID: "123", name: "Clark", lat: 15, lon: 14), BusRouteStop(stopID: "456", name: "Division", lat: 41.8781, lon: -87.6298),])
    return BusRouteDetailView(busRoute: BusRoute(number: "151", name: "Jackson Park Express", color: "#f0f"), viewModel: viewModel)
}
