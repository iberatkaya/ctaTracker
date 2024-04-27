// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

struct GetBusDirectionsAPIResponse: Codable {
    let bustimeResponse: GetBustimeResponse

    enum CodingKeys: String, CodingKey {
        case bustimeResponse = "bustime-response"
    }
}

// MARK: - BustimeResponse
struct GetBustimeResponse: Codable {
    let directions: [GetDirection]
}

// MARK: - Direction
struct GetDirection: Codable {
    let dir: String
}
