//
//  BusRoutesView.swift
//  ctaTracker
//
//  Created by Ibrahim Berat Kaya on 4/24/24.
//

import SwiftUI
import SwiftData

struct BusRoutesView: View {
    @EnvironmentObject var busRoutes: BusRoutes
    @Query(sort: \BusRouteEntity.number) var favoriteBusRoutes: [BusRouteEntity]
    @Environment(\.modelContext) var modelContext
    @StateObject var viewModel = BusRoutesViewModel(routes: [])
    
    var body: some View {
        VStack {
            List {
                if (!favoriteBusRoutes.isEmpty){
                    Section(header: Text("Favorites")) {
                        ForEach(favoriteBusRoutes.map({ BusRoute.fromDataObject(data: $0) }), id: \.number) { route in
                            NavigationLink(destination: BusRouteDetailView(busRoute: route), label: {
                                BusRouteItemView(route: route, onSavePress: saveItem, onDeletePress: removeItem, isFaved: favoriteBusRoutes.map({ $0.number }).contains(route.number))
                            })
                        }
                    }
                }
                
                Section(header: Text("All Routes")) {
                    ForEach(busRoutes.routes, id: \.number) { route in
                        NavigationLink(destination: BusRouteDetailView(busRoute: route), label: {
                            BusRouteItemView(route: route, onSavePress: saveItem, onDeletePress: removeItem, isFaved: favoriteBusRoutes.map({ $0.number }).contains(route.number))
                        })
                    }
                }
            }.onAppear(perform: {
                viewModel.routes = busRoutes.routes
            })
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
}

#Preview {
    BusRoutesView()
        .environmentObject(BusRoutes(routes: [BusRoute(number: "151", name: "Sheridan", color: "#f0f")]))
}
