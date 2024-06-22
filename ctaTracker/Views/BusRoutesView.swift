//
//  BusRoutesView.swift
//  ctaTracker
//
//  Created by Ibrahim Berat Kaya on 4/24/24.
//

import SwiftUI
import SwiftData
import ActivityIndicatorView

struct BusRoutesView: View {
    @EnvironmentObject var busRoutes: BusRoutes
    @Query(sort: \BusRouteEntity.number) var favoriteBusRoutes: [BusRouteEntity]
    @Query(sort: \BusStopEntity.stopID) var favoriteBusStops: [BusStopEntity]
    @Environment(\.modelContext) var modelContext
    @StateObject var viewModel = BusRoutesViewModel(routes: [])
    
    var body: some View {
        VStack {
            if (viewModel.isLoading) {
                ActivityIndicatorView(isVisible: $viewModel.isLoading, type: .growingArc(.blue, lineWidth: 3))
                     .frame(width: 54.0, height: 54.0)
            }
            else {
                List {
                    if (!favoriteBusStops.isEmpty){
                        Section(header: Text("Favorite Stops")) {
                            ForEach(favoriteBusStops, id: \.stopID) { stopData in
                                let stop = BusRouteStop.fromDataObject(data: stopData)
                                
                                NavigationLink(destination: BusStopPredictionsView(busRoute: BusRoute(number: stopData.routeNumber, name: stopData.routeName, color: stopData.routeColor), stop: stop), label: {
                                    BusStopItemView(busStop: stop, isFaved: true, title: "\(stop.name)\n\(stopData.routeNumber) \(stopData.routeDirection)", onDeletePress: removeStopItem)
                                })
                            }
                        }
                    }
                    
                    if (!favoriteBusRoutes.isEmpty){
                        Section(header: Text("Favorite Routes")) {
                            ForEach(favoriteBusRoutes.sorted(by: { a, b in
                                let aNumArr = parseNumbersFromString(a.number)
                                let bNumArr = parseNumbersFromString(b.number)
                                if let aNum = aNumArr.first, let bNum = bNumArr.first {
                                    return aNum < bNum
                                }
                                return true
                            }).map({ BusRoute.fromDataObject(data: $0) }), id: \.number) { route in
                                NavigationLink(destination: BusRouteDetailView(busRoute: route), label: {
                                    BusRouteItemView(route: route, onSavePress: saveRouteItem, onDeletePress: removeRouteItem, isFaved: favoriteBusRoutes.map({ $0.number }).contains(route.number))
                                })
                            }
                        }
                    }
                    
                    Section(header: Text("All Routes")) {
                        ForEach(busRoutes.routes, id: \.number) { route in
                            NavigationLink(destination: BusRouteDetailView(busRoute: route), label: {
                                BusRouteItemView(route: route, onSavePress: saveRouteItem, onDeletePress: removeRouteItem, isFaved: favoriteBusRoutes.map({ $0.number }).contains(route.number))
                            })
                        }
                    }
                }
            }
        }
        .task {
            if let data = await viewModel.fetchData() {
                busRoutes.routes = data
            }
            
        }
        .navigationBarTitle("Bus Tracker", displayMode: .inline)
    }
    
    func removeStopItem(_ item: BusRouteStop) {
        let entity = favoriteBusStops.first(where: { $0.stopID == item.stopID })
        if let entity {
            modelContext.delete(entity)
        }
    }
    
    func saveRouteItem(_ item: BusRoute) {
        let entity = item.toDataModel()
        modelContext.insert(entity)
        try? modelContext.save()
    }
    
    func removeRouteItem(_ item: BusRoute) {
        let entity = favoriteBusRoutes.first(where: { $0.number == item.number })
        if let entity {
            modelContext.delete(entity)
        }
    }
}

#Preview {
    BusRoutesView()
        .environmentObject(BusRoutes(routes: [BusRoute(number: "151", name: "Sheridan", color: "#f0f")]))
}
