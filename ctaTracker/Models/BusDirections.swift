import SwiftUI

class BusDirections: ObservableObject, Observable, Identifiable {
    init(directions: [String]) {
        self.directions = directions
    }
    
    @Published var directions: [String]
    
    static func fromDataObject(data: GetBusDirectionsAPIResponse) -> BusDirections {
        return BusDirections(directions: data.bustimeResponse.directions.map({ $0.dir }))
    }
}
