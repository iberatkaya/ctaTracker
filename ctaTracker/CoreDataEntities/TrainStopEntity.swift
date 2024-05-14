//
//  TrainStopEntity.swift
//  ctaTracker
//
//  Created by Ibrahim Berat Kaya on 5/7/24.
//
//

import Foundation
import SwiftData


@Model public class TrainStopEntity {
    init(mapID: Int64, stationDescription: String, stationName: String, trainLine: String, stopID: Int64) {
        self.mapID = mapID
        self.stationDescription = stationDescription
        self.stationName = stationName
        self.trainLine = trainLine
        self.stopID = stopID
    }
    
    var mapID: Int64
    var stationDescription: String
    var stationName: String
    var trainLine: String
    var stopID: Int64
}
