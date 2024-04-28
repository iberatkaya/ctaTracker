//
//  BusRouteDetailView.swift
//  ctaTracker
//
//  Created by Ibrahim Berat Kaya on 4/24/24.
//

import SwiftUI
import SwiftData

struct BusRouteDetailView: View {
    let busRoute: BusRoute
    @ObservedObject var viewModel: BusRouteDetailsViewModel
    @State var directionIndex: Int = 0
    
    init(busRoute: BusRoute, viewModel: BusRouteDetailsViewModel? = nil) {
        self.busRoute = busRoute
        self.viewModel = viewModel ?? BusRouteDetailsViewModel(busRoute: busRoute)
    }

    var body: some View {
        ScrollView {
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
            
            HStack(alignment: .center, spacing: 4) {
            }
            
            NavigationLink(destination: TransitMapView(busRoute: busRoute, stops: viewModel.busRouteStops), label: { Text("Map") }).padding(.top, 12)
             
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
            
            if (viewModel.stopsLoading) {
                ProgressView()
            } else {
                HStack{
                    VStack(spacing: 0) {
                        ForEach(viewModel.busRouteStops.stops) { stop in
                            NavigationLink(destination: BusStopPredictionsView(busRoute: viewModel.busRoute, stop: stop), label: {
                                HStack {
                                    Image(systemName: "circle.fill")
                                        .font(.system(size: 6)).foregroundColor(Color.black)
                                    Text(stop.name)
                                        .font(.system(size: 16, weight: .regular))
                                        .padding(.vertical, 2)
                                    Spacer()
                                }
                            })
                        }
                    }
                    Spacer()
                }.padding(.horizontal, 16)
            }
        }.task({
            guard !isPreviewBuilder() else { return }
            if (viewModel.didFetchDirectionData) { return }
            await viewModel.fetchDirections()
            print(directionIndex)
            if (viewModel.didFetchStopsData) { return }
            await viewModel.fetchStops(direction: viewModel.busDirections.directions[self.directionIndex])
        })
    }
}

#Preview {
    BusRouteDetailView(busRoute: BusRoute(number: "151", name: "Sheridan", color: "#f0f"), viewModel: BusRouteDetailsViewModel(busRoute: BusRoute(number: "151", name: "Sheridan", color: "#f0f"), directions: BusDirections(directions: ["North", "South"])))
}
