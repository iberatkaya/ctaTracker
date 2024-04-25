import SwiftUI

class BusRoutes: ObservableObject, Observable {
    init(routes: [BusRoute]) {
        self.routes = routes
    }
    
    @Published var routes: [BusRoute]
    
    static func fromDataObject(data: GetRoutesAPIResponse) -> BusRoutes {
        return BusRoutes(routes: data.bustimeResponse.routes.map({ BusRoute(number: $0.rt, name: $0.rtnm, color: $0.rtclr) }))
    }
}

class BusRoute: Identifiable {
    init(number: String, name: String, color: String) {
        self.number = number
        self.name = name
        self.color = color
    }
    
    let number, name, color: String
}
