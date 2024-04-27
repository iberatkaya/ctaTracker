//
//  BusRouteDetailView.swift
//  ctaTracker
//
//  Created by Ibrahim Berat Kaya on 4/24/24.
//

import SwiftUI
import SwiftData

struct BusRouteDetailView: View {
    let busRoute: BusRoute
    @StateObject var busDirections: BusDirections = BusDirections(directions: [])
    @Query(sort: \BusRouteEntity.number) var favoriteBusRoutes: [BusRouteEntity]
    @Environment(\.modelContext) var modelContext

    var body: some View {
        VStack {
            Text(busRoute.name)
            Text(busRoute.number)
            HStack(alignment: .center, spacing: 4) {
                ForEach(Array(busDirections.directions.enumerated()), id: \.offset) { index, direction in
                        Text(direction + (index != (busDirections.directions.count - 1) ? "," : ""))
                            .padding(0)
                }
            }
        }.onAppear(perform: {
            Task {
                let repo = BusRepository()
                guard let res = await repo.getDirections() else { return }
                busDirections.directions = BusDirections.fromDataObject(data: res).directions
            }
        })
    }
}

#Preview {
    BusRouteDetailView(busRoute: BusRoute(number: "151", name: "Sheridan", color: "#f0f"), busDirections: BusDirections(directions: ["Northbound", "Southbound"]))
}
