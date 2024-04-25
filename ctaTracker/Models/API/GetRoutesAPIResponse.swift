
struct GetRoutesAPIResponse: Codable {
    let bustimeResponse: GetRoutesAPIBustimeResponse

    enum CodingKeys: String, CodingKey {
        case bustimeResponse = "bustime-response"
    }
}

// MARK: - BustimeResponse
struct GetRoutesAPIBustimeResponse: Codable {
    let routes: [GetRoutesAPIRoute]
}

// MARK: - Route
struct GetRoutesAPIRoute: Codable {
    let rt, rtnm, rtclr, rtdd: String
}
