//
//  GetBusRouteStopsAPIResponse.swift
//  ctaTracker
//
//  Created by Ibrahim Berat Kaya on 4/27/24.
//

import Foundation

struct GetBusRouteStopsAPIResponse: Codable {
    let bustimeResponse: BustimeResponseAPIResponse

    enum CodingKeys: String, CodingKey {
        case bustimeResponse = "bustime-response"
    }
}

// MARK: - BustimeResponse
struct BustimeResponseAPIResponse: Codable {
    let stops: [StopAPIResponse]
}

// MARK: - Stop
struct StopAPIResponse: Codable {
    let stpid, stpnm: String
    let lat, lon: Double
}
