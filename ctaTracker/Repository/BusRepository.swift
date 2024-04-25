//
//  BusRepository.swift
//  ctaTracker
//
//  Created by Ibrahim Berat Kaya on 4/24/24.
//

import Foundation
import Alamofire

class BusRepository {
    let key: String = Bundle.main.object(forInfoDictionaryKey: "BUS_KEY") as! String
    
    func getRoutes() async -> GetRoutesAPIResponse? {
        let url = "https://www.ctabustracker.com/bustime/api/v2/getroutes?key=" + key + "&format=json"
        let res = try? await AF.request(url, method: .get).serializingDecodable(GetRoutesAPIResponse.self).result.get()
        
        return res
    }
}
