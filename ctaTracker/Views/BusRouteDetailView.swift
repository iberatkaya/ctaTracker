//
//  BusRouteDetailView.swift
//  ctaTracker
//
//  Created by Ibrahim Berat Kaya on 4/24/24.
//

import SwiftUI

struct BusRouteDetailView: View {
    let busRoute: BusRoute
    
    var body: some View {
        VStack {
            Text(busRoute.name)
            Text(busRoute.number)
        }
    }
}

#Preview {
    BusRouteDetailView(busRoute: BusRoute(number: "151", name: "Sheridan", color: "#f0f"))
}
