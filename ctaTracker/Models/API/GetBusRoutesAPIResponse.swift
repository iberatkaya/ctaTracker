
struct GetBusRoutesAPIResponse: Codable {
    let bustimeResponse: GetBusRoutesAPIBustimeResponse

    enum CodingKeys: String, CodingKey {
        case bustimeResponse = "bustime-response"
    }
}

// MARK: - BustimeResponse
struct GetBusRoutesAPIBustimeResponse: Codable {
    let routes: [GetBusRoutesAPIRoute]
}

// MARK: - Route
struct GetBusRoutesAPIRoute: Codable {
    let rt, rtnm, rtclr, rtdd: String
}
