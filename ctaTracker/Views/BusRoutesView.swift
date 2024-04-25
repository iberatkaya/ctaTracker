//
//  BusRoutesView.swift
//  ctaTracker
//
//  Created by Ibrahim Berat Kaya on 4/24/24.
//

import SwiftUI

struct BusRoutesView: View {
    @EnvironmentObject var busRoutes: BusRoutes
    
    var body: some View {
        VStack {
            List {
                ForEach(busRoutes.routes) { route in
                    NavigationLink(destination: BusRouteDetailView(busRoute: route), label: { Text(route.number + " - " + route.name) })
                }
            }
        }
    }
}

#Preview {
    BusRoutesView()
}
