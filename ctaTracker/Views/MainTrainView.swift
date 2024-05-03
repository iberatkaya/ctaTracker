//
//  MainTrainView.swift
//  ctaTracker
//
//  Created by Ibrahim Berat Kaya on 4/30/24.
//

import SwiftUI
import Alamofire

struct MainTrainView: View {
    @StateObject var viewModel = MainTrainViewModel()
    
    var body: some View {
        NavigationStack {
            TrainRoutesView()
        }.task {
            await viewModel.loadJSON()
        }.environment(viewModel.trainStops)
    }
}

#Preview {
    MainBusView().environment(BusRoutes(routes: [BusRoute(number: "151", name: "Sheridan", color: "#ff00ff")]))
}
