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
    @StateObject var busDirections: BusDirections = BusDirections(directions: [])
    @StateObject var busRouteStops: BusRouteStops = BusRouteStops(stops: [])
    @Query(sort: \BusRouteEntity.number) var favoriteBusRoutes: [BusRouteEntity]
    @Environment(\.modelContext) var modelContext
    @State var stopsLoading = false

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
                ForEach(Array(busDirections.directions.enumerated()), id: \.offset) { index, direction in
                        Text(direction + (index != (busDirections.directions.count - 1) ? "," : ""))
                            .padding(0)
                            .font(.system(size: 13, weight: .regular))
                }
            }
             
            Divider().padding(EdgeInsets(top: 4, leading: 0, bottom: 12, trailing: 0))
            
            if (stopsLoading) {
                ProgressView()
            } else {
                HStack{
                    VStack(spacing: 0) {
                        ForEach(busRouteStops.stops) { stop in
                            NavigationLink(destination: BusStopPredictionsView(busRoute: busRoute, stop: stop), label: {
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
            let repo = BusRepository()
            guard let res = await repo.getDirections() else { return }
            busDirections.directions = BusDirections.fromDataObject(data: res).directions
        })
        .task {
            guard !isPreviewBuilder() else { return }
            stopsLoading = true
            let repo = BusRepository()
            guard let res = await repo.getRouteStops(routeNumber: busRoute.number) else { return }
            busRouteStops.stops = BusRouteStops.fromDataObject(data: res).stops
            stopsLoading = false
        }
    }
}

#Preview {
    BusRouteDetailView(busRoute: BusRoute(number: "151", name: "Sheridan", color: "#f0f"), busDirections: BusDirections(directions: ["Northbound", "Southbound"]), busRouteStops: BusRouteStops(stops: [BusRouteStop(stopID: "123", name: "Inner Lake Shore/Michigan Exp.", lat: 12.5, lon: 13.5), BusRouteStop(stopID: "456", name: "1500 DEF Ave", lat: 13.5, lon: 14.5)]))
}
