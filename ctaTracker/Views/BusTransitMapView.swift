//
//  MapView.swift
//  ctaTracker
//
//  Created by Ibrahim Berat Kaya on 4/28/24.
//

import SwiftUI
import MapKit
import ActivityIndicatorView

struct BusTransitMapView: View {
    init(busRoute: BusRoute, stops: BusRouteStops, patterns: BusPatterns? = nil, direction: String? = nil) {
        self.busRoute = busRoute
        self.stops = stops
        self.patterns = patterns ?? BusPatterns(patterns: [])
        self.direction = direction
    }
    
    @ObservedObject var busRoute: BusRoute
    @ObservedObject var stops: BusRouteStops
    @ObservedObject var patterns: BusPatterns
    var direction: String?
    @EnvironmentObject var locationManager: LocationManager
    
    @State var position: MapCameraPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 41.8781, longitude: -87.6298),
            span: MKCoordinateSpan(latitudeDelta: 0.04, longitudeDelta: 0.04)
        )
    )

    var body: some View {
        MapViewContainer(position: $position, content: busRoute.number != "-1" ? {
            Map(position: $position, interactionModes: [.pan, .zoom]) {
                if let location = locationManager.location {
                    Annotation("", coordinate: location) {
                        LocationIndicator()
                    }
                }
                ForEach(Array(stops.stops.enumerated()), id: \.offset) { index, item in
                    Annotation(item.name, coordinate: CLLocationCoordinate2D(latitude: item.lat, longitude: item.lon)) {
                        NavigationLink(destination: { BusStopPredictionsView(busRoute: busRoute, stop: item) }){
                            ZStack {
                                Circle()
                                    .foregroundStyle(.blue.opacity(0.15))
                                    .frame(width: 32, height: 32)
                                
                                Image(systemName: "mappin").foregroundColor(Color(red: 20/255, green: 20/255, blue: 150/255)).font(.system(size: 14))
                            }
                        }
                    }
                }
                if let direction, let pattern = patterns.patterns.first(where: { i in
                    i.routeDirection == direction
                }) {
                    ForEach(Array(pattern.points.enumerated()), id: \.offset) { index, item in
                        if (index + 1 < pattern.points.count) {
                            MapPolyline(coordinates: [item.location, pattern.points[index + 1].location], contourStyle: .geodesic)
                                .stroke(.blue.opacity(0.55), lineWidth: 3.0)
                        }
                    }
                }
            }
        } : nil )
    }
}

#Preview {
    BusTransitMapView(busRoute: BusRoute(number: "151", name: "Sheridan", color: "#f0f"), stops: BusRouteStops(stops: [BusRouteStop(stopID: "123", name: "My Stop", lat: 41.88, lon: -87.627)]), patterns: BusPatterns(patterns: []))
}
