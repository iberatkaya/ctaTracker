//
//  ContentView.swift
//  ctaTracker
//
//  Created by Ibrahim Berat Kaya on 4/22/24.
//

import SwiftUI
import Alamofire

struct MainBusView: View {
    
    @StateObject var viewModel = MainBusViewModel()
    
    var body: some View {
        NavigationStack {
            BusRoutesView()
        }.environment(viewModel.busRoutes)
    }
}

#Preview {
    MainBusView().environment(BusRoutes(routes: [BusRoute(number: "151", name: "Sheridan", color: "#ff00ff")]))
}
