//
//  BusPatterns.swift
//  ctaTracker
//
//  Created by Ibrahim Berat Kaya on 5/16/24.
//

import Foundation
import CoreLocation

class BusPatterns: ObservableObject, Identifiable {
    init(patterns: [BusPattern]) {
        self.patterns = patterns
    }
    
    @Published var patterns: [BusPattern]
    
    static func fromDataObject(data: GetBusRoutePatternsAPIResponse) -> BusPatterns {
        let ptr = data.bustimeResponse.ptr
        let patterns = ptr.map { pointSet in
            let pattern = BusPattern(patternID: pointSet.pid, length: Double(pointSet.ln), routeDirection: pointSet.rtdir, points: pointSet.pt.map({ point in
                let loc = CLLocationCoordinate2D(latitude: point.lat, longitude: point.lon)
                return BusPatternPoint(sequence: point.seq, type: .convertDataObjectToEnum(point.typ), stopID: point.stpid, stopName: point.stpnm, stopDistance: Double(point.pdist), location: loc)
            }))
            
            return pattern
        }
        return BusPatterns(patterns: patterns)
    }
    
}

struct BusPattern {
    let patternID: Int
    let length: Double
    let routeDirection: String
    let points: [BusPatternPoint]
}


struct BusPatternPoint {
    let sequence: Int
    let type: BusPatternPointType
    let stopID: String?
    let stopName: String?
    let stopDistance: Double
    let location: CLLocationCoordinate2D
}


enum BusPatternPointType: String, Codable {
    case s = "S"
    case w = "W"
    
    static func convertDataObjectToEnum(_ data: GetBusRoutePatternsAPITyp) -> BusPatternPointType {
        switch data {
        case .s:
            return .s
        case .w:
            return .w
        }
    }
}
