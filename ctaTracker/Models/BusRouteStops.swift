//
//  BusRouteStops.swift
//  ctaTracker
//
//  Created by Ibrahim Berat Kaya on 4/27/24.
//

import Foundation

class BusRouteStops: ObservableObject, Observable, Identifiable {
    init(stops: [BusRouteStop]) {
        self.stops = stops
    }
    
    @Published var stops: [BusRouteStop]
    
    static func fromDataObject(data: GetBusRouteStopsAPIResponse) -> BusRouteStops {
        return BusRouteStops(stops: data.bustimeResponse.stops.map({ BusRouteStop(stopID: $0.stpid, name: $0.stpnm, lat: $0.lat, lon: $0.lon) }))
    }
}

class BusRouteStop: Identifiable {
    init(stopID: String, name: String, lat: Double, lon: Double) {
        self.stopID = stopID
        self.name = name
        self.lat = lat
        self.lon = lon
    }
    
    let stopID, name: String
    let lat, lon: Double
}
