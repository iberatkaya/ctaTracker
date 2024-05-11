//
//  MapView.swift
//  ctaTracker
//
//  Created by Ibrahim Berat Kaya on 5/11/24.
//

import SwiftUI
import CoreLocation
import MapKit

struct MapView<Content: MapContent>: View {
    
    @Binding var position: MapCameraPosition
    @EnvironmentObject var locationManager: LocationManager
    @State var updateLocation: Bool = false
    
    let content: () -> Content?

    var body: some View {
        ZStack {
            Map(position: $position) {
                if let location = locationManager.location {
                    Annotation("", coordinate: location) {
                        LocationIndicator()
                    }
                }
                content()
            }.mapStyle(
                .standard(
                    elevation: .flat,
                    pointsOfInterest: .excludingAll,
                    showsTraffic: false
                ))
            Button {
                locationManager.requestLocation()
                updateLocation = true
            } label: {
                ZStack {
                    Circle().fill(Color.blue.opacity(0.25))
                        .frame(width: 48, height: 48)
                    Image(systemName: "location")
                        .font(.system(size: 24))
                        .foregroundColor(.blue)
                }
            }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                .offset(x: -16, y: -16)
        }.onAppear(perform: {
            if (locationManager.hasPermission()) {
                locationManager.requestLocation()
            }
        })
        .onReceive(locationManager.$location, perform: { loc in
            if updateLocation, let lat = loc?.latitude, let long = loc?.longitude {
                withAnimation(.easeOut(duration: TimeInterval(1))) {
                    position = MapCameraPosition.region(
                        MKCoordinateRegion(
                            center: CLLocationCoordinate2D(latitude: lat, longitude: long),
                            span: MKCoordinateSpan(latitudeDelta: 0.08, longitudeDelta: 0.08)
                        )
                    )
                }
               updateLocation = false
            }
        })
    }
}

#Preview {
    @State var position: MapCameraPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 41.8781, longitude: -87.6298),
            span: MKCoordinateSpan(latitudeDelta: 0.08, longitudeDelta: 0.08)
        )
    )
    return MapView(position: $position, content: {
        Marker(coordinate: CLLocationCoordinate2D(latitude: 15, longitude: 15), label: { Text("123") })
    })
}
