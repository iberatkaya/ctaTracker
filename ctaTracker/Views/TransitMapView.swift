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
                    Annotation(item.name, coordinate: CLLocationCoordinate2D(latitude: item.lat, longitude: item.lon)) {
                        if let busRoute {
                            NavigationLink(destination: { BusStopPredictionsView(busRoute: busRoute, stop: item) }){
                                ZStack {
                                    Circle()
                                        .foregroundStyle(.blue.opacity(0.15))
                                        .frame(width: 32, height: 32)
                                    
                                    Image(systemName: "mappin").foregroundColor(Color(red: 20/255, green: 20/255, blue: 150/255)).font(.system(size: 14))
                                }
                            }
                        } else {
                            ZStack {
                                Circle()
                                    .foregroundStyle(.blue.opacity(0.15))
                                    .frame(width: 32, height: 32)
                                
                                Image(systemName: "mappin").foregroundColor(Color(red: 20/255, green: 20/255, blue: 150/255)).font(.system(size: 14))
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    TransitMapView(busRoute: BusRoute(number: "151", name: "Sheridan", color: "#f0f"), stops: BusRouteStops(stops: [BusRouteStop(stopID: "123", name: "My Stop", lat: 41.88, lon: -87.627)]))
}
