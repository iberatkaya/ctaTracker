//
//  TrainTransitMapView.swift
//  ctaTracker
//
//  Created by Ibrahim Berat Kaya on 5/7/24.
//

import SwiftUI
import ActivityIndicatorView
import MapKit

struct TrainTransitMapView: View {
    init(train: TrainLine, stops: TrainStops, onSavePress: ((TrainStop) -> Void)? = nil) {
        self.train = train
        self.stops = stops
        self.onSavePress = onSavePress
        _position = State(wrappedValue: MapCameraPosition.region(
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: !stops.stops.isEmpty ? stops.stops[(stops.stops.count - 1) / 2].location.latitude : 41.8781, longitude: !stops.stops.isEmpty ? stops.stops[(stops.stops.count - 1) / 2].location.longitude : -87.6298),
                span: MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15)
            )
        ))
    }
    
    var train: TrainLine
    @ObservedObject var stops: TrainStops
    let onSavePress: ((_ stop: TrainStop) -> Void)?

    @State private var position: MapCameraPosition
    @EnvironmentObject var locationManager: LocationManager
        
    var body: some View {
        ZStack {
            MapViewContainer(position: $position, content: {
                Map(position: $position, interactionModes: [.pan, .zoom]) {
                    if let location = locationManager.location {
                        Annotation("", coordinate: location) {
                            LocationIndicator()
                        }
                    }
                    ForEach(Array(stops.stops.enumerated()), id: \.offset) { index, item in
                        TrainStopAnnotation(trains: [train], stop: item)
                        if (index + 1 < stops.stops.count) {
                            MapPolyline(coordinates: [item.location, stops.stops[index + 1].location], contourStyle: .geodesic)
                                .stroke(mapTrainLineToColor(train).opacity(0.55), lineWidth: 2.0)
                        }
                    }
                }
            })
        }
    }
}

#Preview {
    TrainTransitMapView(train: .red, stops: TrainStops(stops: [TrainStop(stopID: 123, directionID: "123", stopName: "Howard", stationName: "Howard", stationDescription: "Howard", mapID: 123, lines: [.red], location: CLLocationCoordinate2D(latitude: 41.8781, longitude: -87.6298)), TrainStop(stopID: 123, directionID: "123", stopName: "Howard", stationName: "Howard", stationDescription: "Howard", mapID: 123, lines: [.red], location: CLLocationCoordinate2D(latitude: 41.8781, longitude: -87.6398))]))
}
