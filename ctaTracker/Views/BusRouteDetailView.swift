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
    @ObservedObject var viewModel: BusRouteDetailsViewModel
    @State var directionIndex: Int = 0
    @State var mapViewEnabledIndex = 0
    @State var displayOptions = ["Map", "List"]
    
    init(busRoute: BusRoute, viewModel: BusRouteDetailsViewModel? = nil) {
        self.busRoute = busRoute
        self.viewModel = viewModel ?? BusRouteDetailsViewModel(busRoute: busRoute)
    }

    var body: some View {
        VStack {
            VStack {
                Text(busRoute.number).font(.system(size: 32, weight: .semibold))
                Text(busRoute.name)
                    .font(.system(size: 15, weight: .semibold))
            }
            .padding(.horizontal, 32)
            .padding(.vertical, 12)
            .overlay(
                RoundedRectangle(cornerRadius: 32)
                    .stroke(.black, lineWidth: 2)
            )
            
             
            Divider().padding(EdgeInsets(top: 4, leading: 0, bottom: 12, trailing: 0))
            
            VStack {
                Picker("Direction", selection: $directionIndex) {
                    ForEach(0..<viewModel.busDirections.directions.count, id: \.self) { index in
                        Text(viewModel.busDirections.directions[index])
                            .tag(index)
                            .font(.system(size: 14))
                    }
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal, 32)
            .padding(.bottom, 12)
            .onChange(of: directionIndex) {
                Task {
                    await self.viewModel.fetchStops(direction: self.viewModel.busDirections.directions[directionIndex])
                }
            }
            
            VStack {
                Picker("Direction", selection: $mapViewEnabledIndex) {
                    ForEach(0..<displayOptions.count, id: \.self) { index in
                        Text(displayOptions[index])
                            .tag(index)
                            .font(.system(size: 14))
                    }
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal, 32)
            .padding(.bottom, 12)
            
            if (viewModel.stopsLoading && mapViewEnabledIndex != 0) {
                ProgressView()
                Spacer()
            } else {
                if (mapViewEnabledIndex == 0) {
                    VStack{
                        ZStack {
                            TransitMapView(busRoute: viewModel.busRoute, stops: viewModel.busRouteStops)
                            
                            NavigationLink(destination: TransitMapView(busRoute: busRoute, stops: viewModel.busRouteStops), label: {
                                
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
                    }
                } else {
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
                        .listStyle(PlainListStyle())
                    }
                }
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
    var viewModel = BusRouteDetailsViewModel(busRoute: BusRoute(number: "151", name: "Sheridan", color: "#f0f"), directions: BusDirections(directions: ["North", "South"]))
    viewModel.busRouteStops = BusRouteStops(stops: [BusRouteStop(stopID: "123", name: "Clark", lat: 15, lon: 14), BusRouteStop(stopID: "456", name: "Division", lat: 15.1, lon: 14.1),])
    return BusRouteDetailView(busRoute: BusRoute(number: "151", name: "Sheridan", color: "#f0f"), viewModel: viewModel)
}
