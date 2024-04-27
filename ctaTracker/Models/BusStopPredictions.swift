//
//  BusStopPredictions.swift
//  ctaTracker
//
//  Created by Ibrahim Berat Kaya on 4/27/24.
//

import Foundation

class BusStopPredictions: ObservableObject, Observable, Identifiable {
    init(predictions: [BusStopPrediction]) {
        self.predictions = predictions
    }
    
    @Published var predictions: [BusStopPrediction]
    
    static func fromDataObject(data: GetBusStopPredictionsAPIResponse) -> BusStopPredictions {
        return BusStopPredictions(predictions: data.bustimeResponse.prd.map({ BusStopPrediction(predictionTimestamp: $0.tmstmp, type: $0.typ, stopName: $0.stpnm, stopID: $0.stpid, vehicleID: $0.vid, destinationFeetDistance: $0.dstp, route: $0.rt, routeDD: $0.rtdd, routeDirection: $0.rtdir, finalDestination: $0.des, prediction: $0.prdtm, scheduledBlockID: $0.tablockid, scheduledTripID: $0.tatripid, origtatripno: $0.origtatripno, delay: $0.dly, predictionMinutesLeft: $0.prdctdn, zone: $0.zone) }))
    }
}

class BusStopPrediction: Identifiable {
    init(predictionTimestamp: String, type: String, stopName: String, stopID: String, vehicleID: String, destinationFeetDistance: Int, route: String, routeDD: String, routeDirection: String, finalDestination: String, prediction: String, scheduledBlockID: String, scheduledTripID: String, origtatripno: String, delay: Bool, predictionMinutesLeft: String, zone: String) {
        self.predictionTimestamp = predictionTimestamp
        self.type = type
        self.stopName = stopName
        self.stopID = stopID
        self.vehicleID = vehicleID
        self.destinationFeetDistance = destinationFeetDistance
        self.route = route
        self.routeDD = routeDD
        self.routeDirection = routeDirection
        self.finalDestination = finalDestination
        self.prediction = prediction
        self.scheduledBlockID = scheduledBlockID
        self.scheduledTripID = scheduledTripID
        self.origtatripno = origtatripno
        self.delay = delay
        self.predictionMinutesLeft = predictionMinutesLeft
        self.zone = zone
    }
    
    let predictionTimestamp, type, stopName, stopID: String
    let vehicleID: String
    let destinationFeetDistance: Int
    let route, routeDD, routeDirection, finalDestination: String
    let prediction, scheduledBlockID, scheduledTripID, origtatripno: String
    let delay: Bool
    let predictionMinutesLeft, zone: String
}
