//
//  LocationManager.swift
//  ctaTracker
//
//  Created by Ibrahim Berat Kaya on 5/11/24.
//

import Foundation
import CoreLocation
import SwiftUI
import MapKit

// Taken from https://www.hackingwithswift.com/quick-start/swiftui/how-to-read-the-users-location-using-locationbutton
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()

    @Published var location: CLLocationCoordinate2D?
    @Published var changedAuth = false

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyKilometer
    }

    func requestLocation() {
        if (manager.authorizationStatus == .authorizedAlways || manager.authorizationStatus == .authorizedWhenInUse) {
            manager.requestLocation()
        } else {
            manager.requestWhenInUseAuthorization()
            manager.startUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        changedAuth = true
    }
    
    func hasPermission() -> Bool {
        return manager.authorizationStatus == .authorizedAlways || manager.authorizationStatus == .authorizedWhenInUse
    }
    
    #if os(iOS)
    func getDirections(source: CLLocationCoordinate2D, destination: CLLocationCoordinate2D) async -> [MKRoute] {
            let request = MKDirections.Request()
            request.source = MKMapItem(placemark: MKPlacemark(coordinate: source, addressDictionary: nil))
            request.transportType = .transit
            request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destination, addressDictionary: nil))
            request.requestsAlternateRoutes = true
            request.transportType = .automobile
            
            let directions = MKDirections(request: request)
            
            let res = try? await directions.calculate()
            guard let unwrappedResponse = res else { return [] }
            return unwrappedResponse.routes
    }
    #endif
}
