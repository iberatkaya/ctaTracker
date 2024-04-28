//
//  MapView.swift
//  ctaTracker
//
//  Created by Ibrahim Berat Kaya on 4/28/24.
//

import SwiftUI
import MapKit

struct TransitMapView: View {
    init(busRoute: BusRoute? = nil, stops: BusRouteStops? = nil) {
        self.busRoute = busRoute
        self.stops = stops
    }
    
    let busRoute: BusRoute?
    let stops: BusRouteStops?
    
    @State private var position = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 41.8781, longitude: -87.6298),
            span: MKCoordinateSpan(latitudeDelta: 0.04, longitudeDelta: 0.04)
        )
    )

    var body: some View {
        Map(initialPosition: position) {
            if let stops { 
                ForEach(Array(stops.stops.enumerated()), id: \.offset) { index, item in
                    Marker(item.name, coordinate: CLLocationCoordinate2D(latitude: item.lat, longitude: item.lon))
                        .tint(.blue)
                    if (index < stops.stops.count - 1){
                        MapPolyline(coordinates: [CLLocationCoordinate2D(latitude: item.lat, longitude: item.lon), CLLocationCoordinate2D(latitude: stops.stops[index + 1].lat, longitude: stops.stops[index + 1].lon)])
                            .stroke(.blue, lineWidth: 2)
                    }
                }
            }
        }
    }
}

#Preview {
    TransitMapView()
}
