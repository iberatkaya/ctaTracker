//
//  GetTrainArrivalsAPIResponse.swift
//  ctaTracker
//
//  Created by Ibrahim Berat Kaya on 5/2/24.
//

import Foundation

struct GetTrainArrivalsAPIResponse: Codable {
    let ctatt: GetTrainArrivalsAPIResponseCtatt?
}

// MARK: - Ctatt
struct GetTrainArrivalsAPIResponseCtatt: Codable {
    let tmst, errCD: String?
    let errNm: String?
    let eta: [GetTrainArrivalsAPIResponseEta]?

    enum CodingKeys: String, CodingKey {
        case tmst
        case errCD = "errCd"
        case errNm, eta
    }
}

// MARK: - Eta
struct GetTrainArrivalsAPIResponseEta: Codable {
    let staID, stpID, staNm, stpDe: String?
    let rn, rt, destSt, destNm: String?
    let trDR, prdt, arrT, isApp: String?
    let isSch, isDly, isFlt: String?
    //    let flags: nil
    let lat, lon, heading: String?
    
    enum CodingKeys: String, CodingKey {
        case staID = "staId"
        case stpID = "stpId"
        case staNm, stpDe, rn, rt, destSt, destNm
        case trDR = "trDr"
        case prdt, arrT, isApp, isSch, isDly, isFlt, lat, lon, heading
    }
}
