//
//  ContentView.swift
//  ctaTracker
//
//  Created by Ibrahim Berat Kaya on 4/22/24.
//

import SwiftUI
import Alamofire

struct ContentView: View {
    
    @StateObject var viewModel = MainViewModel()
    
    var body: some View {
        NavigationStack {
            BusRoutesView()
        }.task {
                await viewModel.fetchData()
        }.environment(viewModel.busRoutes)
    }
}

#Preview {
    ContentView().environment(BusRoutes(routes: [BusRoute(number: "151", name: "Sheridan", color: "#ff00ff")]))
}
