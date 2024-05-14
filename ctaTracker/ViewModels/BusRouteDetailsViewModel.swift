//
//  BusRouteDetailsViewModel.swift
//  ctaTracker
//
//  Created by Ibrahim Berat Kaya on 4/28/24.
//

import Foundation
import SwiftUI
import SwiftData

@MainActor
class BusRouteDetailsViewModel: ObservableObject {
    init(busRoute: BusRoute, directions: BusDirections? = nil) {
        self.busRoute = busRoute
        self.busDirections = directions ?? BusDirections(directions: [])
    }
    
    let busRoute: BusRoute
    @Published var busDirections: BusDirections
    @Published var busRouteStops: BusRouteStops = BusRouteStops(stops: [])
    @Query(sort: \BusRouteEntity.number) var favoriteBusRoutes: [BusRouteEntity]
    @Environment(\.modelContext) var modelContext
    @Published var stopsLoading = false
    @Published var didFetchStopsData = false
    @Published var didFetchDirectionData = false
    let repo = BusRepository()
    
    func fetchDirections() async {
        guard let res = await repo.getDirections(route: busRoute.number) else { return }
        busDirections.directions = BusDirections.fromDataObject(data: res).directions
        didFetchDirectionData = true
    }
    
    func fetchStops(direction: String) async {
        stopsLoading = true
        guard let res = await repo.getRouteStops(routeNumber: busRoute.number, direction: direction) else { return }
        busRouteStops.stops = BusRouteStops.fromDataObject(data: res).stops
        
        withAnimation(.easeOut(duration: TimeInterval(0.1))) {
            stopsLoading = false
            didFetchStopsData = true
        }
    }
}
