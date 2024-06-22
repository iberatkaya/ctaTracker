//
//  BusStopEntity.swift
//  ctaTracker
//
//  Created by Ibrahim Berat Kaya on 6/1/24.
//
//

import Foundation
import SwiftData


@Model public class BusStopEntity {
    init(stopID: String, name: String, lat: Double, lon: Double, routeDirection: String, routeNumber: String, routeName: String, routeColor: String) {
        self.stopID = stopID
        self.name = name
        self.lat = lat
        self.lon = lon
        self.routeDirection = routeDirection
        self.routeNumber = routeNumber
        self.routeName = routeName
        self.routeColor = routeColor
    }
    
    var lat: Double
    var lon: Double
    var name: String
    var stopID: String
    var routeNumber: String
    var routeDirection: String
    var routeName: String
    var routeColor: String
}
