//
//  LocationManager.swift
//  ctaTracker
//
//  Created by Ibrahim Berat Kaya on 5/11/24.
//

import Foundation
import CoreLocation
import SwiftUI

// Taken from https://www.hackingwithswift.com/quick-start/swiftui/how-to-read-the-users-location-using-locationbutton
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()

    @Published var location: CLLocationCoordinate2D?
    @Published var changedAuth = false

    override init() {
        super.init()
        manager.delegate = self
    }

    func requestLocation() {
        if (manager.authorizationStatus == .authorizedAlways || manager.authorizationStatus == .authorizedWhenInUse) {
            manager.requestLocation()
        } else {
            manager.requestWhenInUseAuthorization()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error.localizedDescription)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        changedAuth = true
    }
    
    func hasPermission() -> Bool {
        return manager.authorizationStatus == .authorizedAlways || manager.authorizationStatus == .authorizedWhenInUse
    }
}
