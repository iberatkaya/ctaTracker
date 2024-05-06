//
//  TrainStopPredictions.swift
//  ctaTracker
//
//  Created by Ibrahim Berat Kaya on 5/3/24.
//


import Foundation
import CoreLocation

class TrainStopPredictions: ObservableObject, Observable, Identifiable {
    init(predictions: [TrainStopPrediction]) {
        self.predictions = predictions
    }
    
    @Published var predictions: [TrainStopPrediction]
 
    
    static func fromDataObject(data: GetTrainArrivalsAPIResponse) throws -> TrainStopPredictions {
        return TrainStopPredictions(predictions: try data.ctatt.eta.map({ try TrainStopPrediction.fromDataObject(data: $0) }))
    }
}

struct TrainStopPrediction {
    init(predictionTimestamp: String, stationID: String, stopID: String, stationName: String, platformDescription: String, runNumber: String, routeName: String, destinationID: String, destinationName: String, routeDirectionCode: String, arrivalTime: String, isApproaching: Bool, isScheduled: Bool, isFaulty: Bool, isDelayed: Bool, location: CLLocationCoordinate2D?, heading: String?) {
        self.predictionTimestamp = predictionTimestamp
        self.stationID = stationID
        self.stopID = stopID
        self.stationName = stationName
        self.platformDescription = platformDescription
        self.runNumber = runNumber
        self.routeName = routeName
        self.destinationID = destinationID
        self.destinationName = destinationName
        self.routeDirectionCode = routeDirectionCode
        self.arrivalTime = arrivalTime
        self.isApproaching = isApproaching
        self.isScheduled = isScheduled
        self.isFaulty = isFaulty
        self.isDelayed = isDelayed
        self.location = location
        self.heading = heading
    }
    
    let predictionTimestamp, stationID, stopID, stationName: String
    let platformDescription, runNumber, routeName, destinationID, destinationName: String
    let routeDirectionCode, arrivalTime: String
    let isApproaching, isScheduled, isFaulty, isDelayed: Bool
    let location: CLLocationCoordinate2D?
    let heading: String?
    
    static func fromDataObject(data: GetTrainArrivalsAPIResponseEta) throws -> TrainStopPrediction {
        var loc: CLLocationCoordinate2D?
        if let latStr = data.lat, let lonStr = data.lon, let lat = Double(latStr), let lon = Double(lonStr) {
            loc = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        }
        return TrainStopPrediction(predictionTimestamp: data.prdt, stationID: data.staID, stopID: data.stpID, stationName: data.staNm, platformDescription: data.stpDe, runNumber: data.rn, routeName: data.rt, destinationID: data.destSt, destinationName: data.destNm, routeDirectionCode: data.trDR, arrivalTime: data.arrT, isApproaching: data.isApp == "1", isScheduled: data.isSch == "1", isFaulty: data.isFlt == "1", isDelayed: data.isDly == "1", location: loc, heading: data.heading)
    }
}
