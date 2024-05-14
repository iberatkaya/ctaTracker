//
//  BusRepository.swift
//  ctaTracker
//
//  Created by Ibrahim Berat Kaya on 4/24/24.
//

import Foundation
import Alamofire

class BusRepository {
    private let key: String = Bundle.main.object(forInfoDictionaryKey: "BUS_KEY") as! String
    
    func getRoutes() async -> GetBusRoutesAPIResponse? {
        let url = "https://www.ctabustracker.com/bustime/api/v2/getroutes?key=" + key + "&format=json"
        let res = try? await AF.request(url, method: .get).serializingDecodable(GetBusRoutesAPIResponse.self).result.get()
        
        return res
    }
    
    func getDirections(route: String) async -> GetBusDirectionsAPIResponse? {
        let url = "https://www.ctabustracker.com/bustime/api/v2/getdirections?key=" + key + "&format=json&rt=" + route
        let res = try? await AF.request(url, method: .get).serializingDecodable(GetBusDirectionsAPIResponse.self).result.get()
        
        return res
    }
    
    func getRouteStops(routeNumber: String, direction: String) async -> GetBusRouteStopsAPIResponse? {
        let url = "https://www.ctabustracker.com/bustime/api/v2/getstops?key=" + key + "&format=json&rt=" + routeNumber + "&dir=" + direction
        let res = try? await AF.request(url, method: .get).serializingDecodable(GetBusRouteStopsAPIResponse.self).result.get()
        
        return res
    }
    
    func getRouteStopPredictions(routeNumber: String,stopID: String) async -> GetBusStopPredictionsAPIResponse? {
        let url = "https://www.ctabustracker.com/bustime/api/v2/getpredictions?key=" + key + "&format=json&rt=" + routeNumber + "&stpid=" + stopID
        let res = await AF.request(url, method: .get).serializingDecodable(GetBusStopPredictionsAPIResponse.self).result
        switch (res) {
        case .success(let data):
            return data
        case .failure(_):
            return nil
        }
    }
}
