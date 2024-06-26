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
    @Query(sort: \BusStopEntity.stopID) var favoriteBusRouteStops: [BusStopEntity]
    @Environment(\.modelContext) var modelContext

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
                                    BusStopItemView(busStop: stop, isFaved: favoriteBusRouteStops.contains(where: { $0.stopID == stop.stopID }), onSavePress: saveItem, onDeletePress: removeItem)
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
    
    func saveItem(_ item: BusRouteStop) {
        let entity = item.toDataModel(routeDirection: viewModel.busDirections.directions[self.directionIndex], routeNumber: busRoute.number, routeName: busRoute.name, routeColor: busRoute.color)
        modelContext.insert(entity)
        try? modelContext.save()
    }
    
    func removeItem(_ item: BusRouteStop) {
        let entity = favoriteBusRouteStops.first(where: { $0.stopID == item.stopID })
        if let entity {
            modelContext.delete(entity)
        }
    }
}

#Preview {
    var viewModel = BusRouteDetailsViewModel(busRoute: BusRoute(number: "151", name: "Jackson Park Express", color: "#f0f"), directions: BusDirections(directions: ["Northbound", "Southbound"]))
    viewModel.busRouteStops = BusRouteStops(stops: [BusRouteStop(stopID: "123", name: "Clark", lat: 15, lon: 14), BusRouteStop(stopID: "456", name: "Division", lat: 41.8781, lon: -87.6298),])
    return BusRouteDetailView(busRoute: BusRoute(number: "151", name: "Jackson Park Express", color: "#f0f"), viewModel: viewModel)
}
