//
//  GetBusStopPredictions.swift
//  ctaTracker
//
//  Created by Ibrahim Berat Kaya on 4/27/24.
//

import Foundation

struct GetBusStopPredictionsAPIResponse: Codable {
    let bustimeResponse: BustimePredictionAPIResponse

    enum CodingKeys: String, CodingKey {
        case bustimeResponse = "bustime-response"
    }
}

// MARK: - BustimeResponse
struct BustimePredictionAPIResponse: Codable {
    let prd: [PrdAPIResponse]?
    
//    let error: GetBusStopPredictionsErrorAPIResponse?
}

// MARK: - Prd
struct PrdAPIResponse: Codable {
    let tmstmp, typ, stpnm, stpid: String
    let vid: String
    let dstp: Int
    let rt, rtdd, rtdir, des: String
    let prdtm, tablockid, tatripid, origtatripno: String
    let dly: Bool
    let prdctdn, zone: String
}

enum GetBusStopPredictionsAPIResponseError: Error {
    case noScheduledService
}
