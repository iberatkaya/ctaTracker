//
//  TrainRoute.swift
//  ctaTracker
//
//  Created by Ibrahim Berat Kaya on 4/30/24.
//

import Foundation

//@Observable class TrainRoutes: ObservableObject {
//    init(routes: [TrainRoute]) {
//        self.routes = routes
//    }
//    
//    var routes: [TrainRoute]
//    
//    static func fromDataObject(data: [GetTrainRouteAPIResponse]) throws -> TrainRoutes {
//        return TrainRoutes(routes: try data.map({
//            do {
//                let res = try TrainRoute.fromDataObject(data: $0)
//                return res
//            } catch {
//                throw error
//            }
//        }))
//    }
//}
//
//struct TrainRoute {
//    let name: String
//    let stops: [TrainStop]
//    
//    static func fromDataObject(data: GetTrainRouteAPIResponse) throws -> TrainRoute {
//        if let route = data.ctatt.route.first {
//            return TrainRoute(name: route.name, stops: route.train.map({ TrainStop.fromDataObject(data: $0) }))
//        } else {
//            throw GetTrainRouteAPIResponseError.noValidRoute
//        }
//    }
//}

// MARK: - Train
//struct TrainStop {
//    init(destinationStopID: String? = nil, destination: String, runNumber: String, trainRouteDirectionCode: String, nextStationID: String, nextStopID: String, nextStationName: String, predictionTime: String, arrivalTime: String, isApproaching: Bool, isDelayed: Bool, lat: Double, long: Double, heading: Int) {
//        self.destinationStopID = destinationStopID
//        self.destination = destination
//        self.runNumber = runNumber
//        self.trainRouteDirectionCode = trainRouteDirectionCode
//        self.nextStationID = nextStationID
//        self.nextStopID = nextStopID
//        self.nextStationName = nextStationName
//        self.predictionTime = predictionTime
//        self.arrivalTime = arrivalTime
//        self.isApproaching = isApproaching
//        self.isDelayed = isDelayed
//        self.lat = lat
//        self.long = long
//        self.heading = heading
//    }
//    
//    let destinationStopID: String?
//    let destination: String
//    let runNumber: String
//    let trainRouteDirectionCode: String
//    let nextStationID: String
//    let nextStopID: String
//    let nextStationName: String
//    let predictionTime: String
//    let arrivalTime: String
//    let isApproaching: Bool
//    let isDelayed: Bool
//    let lat: Double
//    let long: Double
//    let heading: Int
//    
//    static func fromDataObject(data: GetTrainRouteAPIResponseTrain) -> TrainStop {
//        return TrainStop(destinationStopID: data.destNm, destination: data.destNm, runNumber: data.rn, trainRouteDirectionCode: data.trDR, nextStationID: data.nextStaID, nextStopID: data.nextStpID, nextStationName: data.nextStaNm, predictionTime: data.prdt, arrivalTime: data.arrT, isApproaching: data.isApp == "1", isDelayed: data.isDly == "1", lat: Double(data.lat) ?? 0, long: Double(data.lon) ?? 0, heading: Int(data.heading) ?? 0)
//    }
//}
