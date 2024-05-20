//
//  GetBusRoutePatternsAPIResponse.swift
//  ctaTracker
//
//  Created by Ibrahim Berat Kaya on 5/16/24.
//

import Foundation

struct GetBusRoutePatternsAPIResponse: Codable {
    let bustimeResponse: GetBusRoutePatternsAPIBustimeResponse

    enum CodingKeys: String, CodingKey {
        case bustimeResponse = "bustime-response"
    }
}

struct GetBusRoutePatternsAPIBustimeResponse: Codable {
    let ptr: [GetBusRoutePatternsAPIPtr]
}

struct GetBusRoutePatternsAPIPtr: Codable {
    let pid, ln: Int
    let rtdir: String
    let pt: [GetBusRoutePatternsAPIPt]
}

struct GetBusRoutePatternsAPIPt: Codable {
    let seq: Int
    let lat, lon: Double
    let typ: GetBusRoutePatternsAPITyp
    let stpid, stpnm: String?
    let pdist: Int
}


enum GetBusRoutePatternsAPITyp: String, Codable {
    case s = "S"
    case w = "W"
}
