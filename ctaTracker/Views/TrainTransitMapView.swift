//
//  TrainTransitMapView.swift
//  ctaTracker
//
//  Created by Ibrahim Berat Kaya on 5/7/24.
//

import SwiftUI
import MapKit

struct TrainTransitMapView: View {
    init(train: TrainLine, stops: TrainStops, onSavePress: ((TrainStop) -> Void)? = nil) {
        self.train = train
        self.stops = stops
        self.onSavePress = onSavePress
    }
    
    var train: TrainLine
    @ObservedObject var stops: TrainStops
    let onSavePress: ((_ stop: TrainStop) -> Void)?
    @State private var triggerNavOnClick = false

    @State private var position = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 41.8781, longitude: -87.6298),
            span: MKCoordinateSpan(latitudeDelta: 0.04, longitudeDelta: 0.04)
        )
    )

    var body: some View {
        Map(initialPosition: position) {
            ForEach(Array(stops.stops.enumerated()), id: \.offset) { index, item in
                Annotation(item.stationName, coordinate: item.location) {
                    NavigationLink(destination: { TrainStopPredictionsView(train: train, trainStop: item) }){
                        ZStack {
                            Circle()
                                .foregroundStyle(mapTrainLineToColor(train).opacity(0.15))
                                .frame(width: 28, height: 28)
                            
                            Image(systemName: "mappin").foregroundColor(mapTrainLineToColor(train)).font(.system(size: 16)).brightness(-0.2)
                        }
                    }
                }
                if (index + 1 < stops.stops.count) {
                    MapPolyline(coordinates: [item.location, stops.stops[index + 1].location], contourStyle: .geodesic)
                        .stroke(mapTrainLineToColor(train).opacity(0.55), lineWidth: 2.0)
                }
            }
        }.mapStyle(
            .standard(
                elevation: .flat,
                pointsOfInterest: .excludingAll,
                showsTraffic: false
            ))
    }
}

#Preview {
    TrainTransitMapView(train: .red, stops: TrainStops(stops: [TrainStop(stopID: 123, directionID: "123", stopName: "Howard", stationName: "Howard", stationDescription: "Howard", mapID: 123, lines: [.red], location: CLLocationCoordinate2D(latitude: 41.8781, longitude: -87.6298)), TrainStop(stopID: 123, directionID: "123", stopName: "Howard", stationName: "Howard", stationDescription: "Howard", mapID: 123, lines: [.red], location: CLLocationCoordinate2D(latitude: 41.8781, longitude: -87.6398))]))
}
