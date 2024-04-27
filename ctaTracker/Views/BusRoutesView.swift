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
    
    var body: some View {
        VStack {
            List {
                ForEach(busRoutes.routes) { route in
                    NavigationLink(destination: BusRouteDetailView(busRoute: route), label: {
                        let isFaved = favoriteBusRoutes.map({ $0.number }).contains(route.number)
                        HStack {
                            if (isFaved) {
                                Image(systemName: "star.fill")
                                    .font(.system(size: 16, weight: .light)).foregroundColor(Color.yellow)
                            }
                            Text(route.number + " - " + route.name)
                                .swipeActions {
                                    if (isFaved) {
                                        Button("Delete") {
                                            removeItem(route)
                                        }
                                        .tint(.red)
                                    } else {
                                        Button("Save") {
                                            saveItem(route)
                                        }
                                        .tint(.yellow)
                                    }
                                }
                        }
                    })
                }
            }
        }
    }
    
    func saveItem(_ item: BusRoute) {
        let entity = item.toDataModel()
        modelContext.insert(entity)
        try? modelContext.save()
        print("Save item")
    }
    
    func removeItem(_ item: BusRoute) {
        let entity = favoriteBusRoutes.first(where: { $0.number == item.number })
        if let entity {
            modelContext.delete(entity)
            print("Delete item")
        }
    }
}

#Preview {
    BusRoutesView()
        .environmentObject(BusRoutes(routes: [BusRoute(number: "151", name: "Sheridan", color: "#f0f")]))
}
