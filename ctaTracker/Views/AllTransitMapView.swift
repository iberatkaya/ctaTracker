//
//  AllTrainsMapView.swift
//  ctaTracker
//
//  Created by Ibrahim Berat Kaya on 5/11/24.
//

import SwiftUI
import MapKit


struct AllTransitMapView: View {
    @State var position = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 41.8781, longitude: -87.6298),
            span: MKCoordinateSpan(latitudeDelta: 0.04, longitudeDelta: 0.04)
        )
    )
    @EnvironmentObject var locationManager: LocationManager
    @EnvironmentObject var trainStops: TrainStops
    @State var allStops = getAllStopsMarkers([])
    @State var selectedLine: TrainLine = .red
    @State var focusLocationOnLaunch = true
        
    var body: some View {
        MapViewContainer(position: $position) {
            Map(position: $position, interactionModes: [.pan, .zoom]) {
                if let location = locationManager.location {
                    Annotation("", coordinate: location) {
                        LocationIndicator()
                    }
                }
                ForEach(allStops, id: \.id) { stop in
                    TrainStopAnnotation(trains: stop.lines, stop: stop)
                }
                
                ForEach(TrainLine.allCases, id: \.rawValue) { line in
                    let stopsOrdered = getSortedStopsByLine(train: line, allStops: trainStops.stops).compactMap({ $0 })
                    ForEach(Array(stopsOrdered.enumerated()), id: \.offset) { index, stop in
                        if index + 1 < stopsOrdered.count {
                            let nextItem = stopsOrdered[index + 1]
                            MapPolyline(coordinates: [stop.location, nextItem.location], contourStyle: .geodesic)
                                .stroke(mapTrainLineToColor(line).opacity(0.65), lineWidth: 2.5)
                        }
                    }
                }
            }.mapStyle(
                .standard(
                    elevation: .flat,
                    pointsOfInterest: .excludingAll,
                    showsTraffic: false
                ))
        }.onReceive(trainStops.$stops, perform: { stops in
            if allStops.count == 0 {
                allStops = getAllStopsMarkers(stops)
            }
        })
        .onReceive(locationManager.$location, perform: { loc in
            if let loc, focusLocationOnLaunch {
                position = MapCameraPosition.region(
                    MKCoordinateRegion(
                        center: CLLocationCoordinate2D(latitude: loc.latitude, longitude: loc.longitude),
                        span: MKCoordinateSpan(latitudeDelta: 0.04, longitudeDelta: 0.04)
                    )
                )
            }
        })
    }
}

#Preview {
    AllTransitMapView()
}
