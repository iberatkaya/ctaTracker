//
//  MapView.swift
//  ctaTracker
//
//  Created by Ibrahim Berat Kaya on 5/11/24.
//

import SwiftUI
import CoreLocation
import MapKit

struct MapViewContainer<Content: View>: View  {
    
    @Binding var position: MapCameraPosition
    @EnvironmentObject var locationManager: LocationManager
    @State var updateLocation: Bool = false
    @State var loadedInitialLocation = false
    
    let onSelectedLineChange: ((_ line: TrainLine) -> Void)? = nil
    
    let content: (() -> Content)?

    var body: some View {
        ZStack {
            content?()
          
            Button {
                locationManager.requestLocation()
                updateLocation = true
            } label: {
                ZStack {
                    Circle().fill(Color.blue.opacity(0.25))
                        .frame(width: 42, height: 42)
                    Image(systemName: "location")
                        .font(.system(size: 22))
                        .foregroundColor(.blue)
                }
            }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                .offset(x: -16, y: -16)
        }.onAppear(perform: !loadedInitialLocation ? {
            if (locationManager.hasPermission()) {
                locationManager.requestLocation()
            }
            loadedInitialLocation = true
        } : nil)
        .onReceive(locationManager.$location, perform: { loc in
            if updateLocation, let lat = loc?.latitude, let long = loc?.longitude {
                withAnimation(.easeOut(duration: TimeInterval(1))) {
                    position = MapCameraPosition.region(
                        MKCoordinateRegion(
                            center: CLLocationCoordinate2D(latitude: lat, longitude: long),
                            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
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
    return MapViewContainer(position: $position, content: {
        Map(position: $position) {
            Marker(coordinate: CLLocationCoordinate2D(latitude: 15, longitude: 15), label: { Text("123") })
        }
    })
}
