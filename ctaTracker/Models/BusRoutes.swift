import SwiftUI

@Observable class BusRoutes: ObservableObject {
    init(routes: [BusRoute]) {
        self.routes = routes
    }
    
    var routes: [BusRoute]
    
    static func fromDataObject(data: GetBusRoutesAPIResponse) -> BusRoutes {
        return BusRoutes(routes: data.bustimeResponse.routes.map({ BusRoute(number: $0.rt, name: $0.rtnm, color: $0.rtclr) }))
    }
}

class BusRoute: ObservableObject {
    init(number: String, name: String, color: String) {
        self.number = number
        self.name = name
        self.color = color
    }
    
    let number, name, color: String
    
    func toDataModel() -> BusRouteEntity {
        let entity = BusRouteEntity(color: color, name: name, number: number)
        return entity
    }
    
    static func fromDataObject(data: BusRouteEntity) -> BusRoute {
        return BusRoute(number: data.number, name: data.name, color: data.color)
    }
}
