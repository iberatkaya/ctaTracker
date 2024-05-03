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
