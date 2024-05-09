//
//  BusRouteDetailView.swift
//  ctaTracker
//
//  Created by Ibrahim Berat Kaya on 4/24/24.
//

import SwiftUI
import SwiftData

struct BusRouteDetailView: View {
    @State var busRoute: BusRoute
    @StateObject var viewModel: BusRouteDetailsViewModel
    @State var directionIndex: Int = 0
    @State var mapViewEnabledIndex = 0
    @State var displayOptions = ["Map", "List"]

    init(busRoute: BusRoute, viewModel: BusRouteDetailsViewModel? = nil) {
        self.busRoute = busRoute
        self._viewModel = StateObject(wrappedValue:viewModel ?? BusRouteDetailsViewModel(busRoute: busRoute))
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    Text(busRoute.name).font(.system(size: 15, weight: .semibold))
                        .scaledToFit()
                        .minimumScaleFactor(0.8)
                    Text(busRoute.number)
                        .font(.system(size: 13))
                }
                Spacer()
                
                Picker("Direction", selection: $directionIndex) {
                    ForEach(0..<viewModel.busDirections.directions.count, id: \.self) { index in
                        Text(viewModel.busDirections.directions[index])
                            .tag(index)
                            .font(.system(size: 16))
                            .scaledToFit()
                            .minimumScaleFactor(0.5)
                    }
                }
                .pickerStyle(.segmented)
                .frame(width: 160)
                .padding(.bottom, 8)
                .padding(.leading, 16)
                .onChange(of: directionIndex) {
                    Task {
                        await self.viewModel.fetchStops(direction: self.viewModel.busDirections.directions[directionIndex])
                    }
                }
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 8)
            
             
            Divider()
            
            if (viewModel.stopsLoading && mapViewEnabledIndex != 0) {
                ProgressView()
                Spacer()
            } else {
                VStack {
                    Picker("Type", selection: $mapViewEnabledIndex) {
                        ForEach(0..<displayOptions.count, id: \.self) { index in
                            if (index == 0) {
                                Image(systemName: "map.circle")
                                    .tag(0)
                            } else {
                                Image(systemName: "list.bullet.circle")
                                    .tag(1)
                            }
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal, 2)
                    .padding(.bottom, 4)
                    .padding(.top, 4)
                }.background(.gray.opacity(0.12))
                
                TabView(selection: $mapViewEnabledIndex) {
                    VStack{
                        ZStack {
                            BusTransitMapView(busRoute: viewModel.busRoute, stops: viewModel.busRouteStops)
                            
                            NavigationLink(destination: BusTransitMapView(busRoute: busRoute, stops: viewModel.busRouteStops), label: {
                                
                                Text("Full Screen")
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 4)
                                    .background(.gray.opacity(0.25))
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                    .font(.system(size: 15, weight: .semibold))
                                    .foregroundColor(.blue)
                            })
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                            .offset(x: -12, y: -8)
                        }
                    }.tag(0)
                    
                    VStack(spacing: 0) {
                        List {
                            ForEach(viewModel.busRouteStops.stops) { stop in
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
                                })
                            }
                        }
                    }.tag(1)
                }.tabViewStyle(.page(indexDisplayMode: .never))
            }
        }.task({
            guard !isPreviewBuilder() else { return }
            if (viewModel.didFetchDirectionData) { return }
            await viewModel.fetchDirections()
            if (viewModel.didFetchStopsData) { return }
            await viewModel.fetchStops(direction: viewModel.busDirections.directions[self.directionIndex])
        })
        .padding(.top, 8)
    }
}

#Preview {
    var viewModel = BusRouteDetailsViewModel(busRoute: BusRoute(number: "151", name: "Jackson Park Express", color: "#f0f"), directions: BusDirections(directions: ["Northbound", "Southbound"]))
    viewModel.busRouteStops = BusRouteStops(stops: [BusRouteStop(stopID: "123", name: "Clark", lat: 15, lon: 14), BusRouteStop(stopID: "456", name: "Division", lat: 41.8781, lon: -87.6298),])
    return BusRouteDetailView(busRoute: BusRoute(number: "151", name: "Jackson Park Express", color: "#f0f"), viewModel: viewModel)
}
