// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

struct GetBusDirectionsAPIResponse: Codable {
    let bustimeResponse: GetBustimeAPIResponse

    enum CodingKeys: String, CodingKey {
        case bustimeResponse = "bustime-response"
    }
}

// MARK: - BustimeResponse
struct GetBustimeAPIResponse: Codable {
    let directions: [GetDirectionAPIResponse]
}

// MARK: - Direction
struct GetDirectionAPIResponse: Codable {
    let dir: String
}
