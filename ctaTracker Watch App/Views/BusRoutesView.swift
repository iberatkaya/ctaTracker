//
//  BusRoutesView.swift
//  ctaTracker Watch App
//
//  Created by Ibrahim Berat Kaya on 5/19/24.
//

import SwiftUI
import ActivityIndicatorView
import SwiftData

struct BusRoutesView: View {
    @ObservedObject var viewModel = BusRoutesViewModel(routes: [])
    @EnvironmentObject var busRoutes: BusRoutes
    @Query(sort: \BusRouteEntity.number) var favoriteBusRoutes: [BusRouteEntity]
    @Query(sort: \BusStopEntity.stopID) var favoriteBusStops: [BusStopEntity]
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        List {
            if viewModel.isLoading {
                ProgressView()
            } else {
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
                
                if !favoriteBusRoutes.isEmpty {
                    Section(header: Text("Favorite Routes")) {
                        ForEach(favoriteBusRoutes.sorted(by: { a, b in
                            let aNumArr = parseNumbersFromString(a.number)
                            let bNumArr = parseNumbersFromString(b.number)
                            if let aNum = aNumArr.first, let bNum = bNumArr.first {
                                return aNum < bNum
                            }
                            return true
                        }), id: \.name) { routeData in
                            let route = BusRoute.fromDataObject(data: routeData)
                            NavigationLink {
                                BusRouteDetailView(busRoute: route)
                            } label: {
                                BusRouteItemView(route: route, onSavePress: saveItem, onDeletePress: removeItem, isFaved: favoriteBusRoutes.map({ $0.number }).contains(route.number))
                            }
                        }
                    }
                }
                Section(header: Text("Bus Routes")) {
                    ForEach(viewModel.busRoutes.routes, id: \.name) { route in
                        NavigationLink {
                            BusRouteDetailView(busRoute: route)
                        } label: {
                            BusRouteItemView(route: route, onSavePress: saveItem, onDeletePress: removeItem, isFaved: favoriteBusRoutes.map({ $0.number }).contains(route.number))
                        }
                    }
                }
            }
        }
        .padding(.horizontal, 2)
        .task {
            _ = await viewModel.fetchData()
        }
    }
    
    
    func saveItem(_ item: BusRoute) {
        let entity = item.toDataModel()
        modelContext.insert(entity)
        try? modelContext.save()
    }
    
    func removeItem(_ item: BusRoute) {
        let entity = favoriteBusRoutes.first(where: { $0.number == item.number })
        if let entity {
            modelContext.delete(entity)
        }
    }
    
    func removeStopItem(_ item: BusRouteStop) {
        let entity = favoriteBusStops.first(where: { $0.stopID == item.stopID })
        if let entity {
            modelContext.delete(entity)
        }
    }
}

#Preview {
    BusRoutesView(viewModel: BusRoutesViewModel(routes: [BusRoute(number: "151", name: "Sheridan", color: "Blue")]))
}
