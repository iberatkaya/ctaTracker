//
//  TrainRepository.swift
//  ctaTracker
//
//  Created by Ibrahim Berat Kaya on 4/30/24.
//


import Foundation
import Alamofire

class TrainRepository {
    private let key: String = Bundle.main.object(forInfoDictionaryKey: "TRAIN_KEY") as! String
    
    func getArrivals(mapID: String) async throws -> GetTrainArrivalsAPIResponse {
        let url = "https://lapi.transitchicago.com/api/1.0/ttarrivals.aspx?key=" + key + "&outputType=JSON&&mapid=" + mapID + "&outputType=json"
        print(url)
        let res = try await AF.request(url, method: .get).serializingDecodable(GetTrainArrivalsAPIResponse.self).result.get()
        
        return res
    }
}
