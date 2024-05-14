//
//  MainTrainView.swift
//  ctaTracker
//
//  Created by Ibrahim Berat Kaya on 4/30/24.
//

import SwiftUI

struct MainTrainView: View {
    var body: some View {
        NavigationStack {
            TrainRoutesView()
        }
    }
}

#Preview {
    MainBusView().environment(BusRoutes(routes: [BusRoute(number: "151", name: "Sheridan", color: "#ff00ff")]))
}
