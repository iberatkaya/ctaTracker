//
//  TrainStop.swift
//  ctaTracker
//
//  Created by Ibrahim Berat Kaya on 5/2/24.
//

import Foundation
import CoreLocation

class TrainStops: ObservableObject, Observable, Identifiable {
    init(stops: [TrainStop] = []) {
        self.stops = stops
    }
    
    var stops: [TrainStop]
    
    static func fromJSON(data: [TrainStopJSONData]) -> TrainStops {
        return TrainStops(stops: data.map({ TrainStop.fromJSON($0) }))
    }
}

class TrainStop: ObservableObject, Identifiable {
    init(stopID: Int, directionID: String, stopName: String, stationName: String, stationDescription: String, mapID: Int, lines: [TrainLine], location: CLLocationCoordinate2D) {
        self.stopID = stopID
        self.directionID = directionID
        self.stopName = stopName
        self.stationName = stationName
        self.stationDescription = stationDescription
        self.mapID = mapID
        self.lines = lines
        self.location = location
    }
    
    let stopID: Int
    let directionID: String
    let stopName: String
    let stationName: String
    let stationDescription: String
    let mapID: Int
    let lines: [TrainLine]
    let location: CLLocationCoordinate2D
    
    static func fromJSON(_ data: TrainStopJSONData) -> TrainStop {
        return TrainStop(stopID: data.STOP_ID, directionID: data.DIRECTION_ID, stopName: data.STOP_NAME, stationName: data.STATION_NAME, stationDescription: data.STATION_DESCRIPTIVE_NAME, mapID: data.MAP_ID, lines: mapBoolLineToTrainLine(data), location: parseLocationStringToLocation(data.Location) ?? CLLocationCoordinate2D(latitude: 0, longitude: 0))
    }
    
    private static func mapBoolLineToTrainLine(_ data: TrainStopJSONData) -> [TrainLine] {
        var line: [TrainLine] = []
        if (data.RED) { line.append(TrainLine.red) }
        if (data.BLUE) { line.append(TrainLine.blue) }
        if (data.G) { line.append(TrainLine.green) }
        if (data.BRN) { line.append(TrainLine.brown) }
        if (data.P) { line.append(TrainLine.purple) }
        if (data.Pexp) { line.append(TrainLine.purpleExpress) }
        if (data.Y) { line.append(TrainLine.yellow) }
        if (data.Pnk) { line.append(TrainLine.red) }
        if (data.O) { line.append(TrainLine.orange) }
        return line
    }
    
    func toDataModel(selectedLine: TrainLine) -> TrainStopEntity {
        let entity = TrainStopEntity(mapID: Int64(mapID), stationDescription: stationDescription, stationName: stationName, trainLine: selectedLine.rawValue, stopID: Int64(stopID))
        return entity
    }
    
    static func fromDataObject(data: TrainStopEntity, allTrainStopData: [TrainStop]) throws -> TrainStop {
        if let item = allTrainStopData.first(where: { $0.mapID == data.mapID }) {
            return item
        }
        throw TrainStopEntityError.missingData
    }
}

struct TrainStopJSONData: Decodable {
    let STOP_ID: Int
    let DIRECTION_ID: String
    let STOP_NAME: String
    let STATION_NAME: String
    let STATION_DESCRIPTIVE_NAME: String
    let MAP_ID: Int
    let ADA: Bool
    let RED: Bool
    let BLUE: Bool
    let G: Bool
    let BRN: Bool
    let P: Bool
    let Pexp: Bool
    let Y: Bool
    let Pnk: Bool
    let O: Bool
    let Location: String
}

enum TrainStopEntityError: Error {
    case missingData
}
