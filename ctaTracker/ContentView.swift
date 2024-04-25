//
//  ContentView.swift
//  ctaTracker
//
//  Created by Ibrahim Berat Kaya on 4/22/24.
//

import SwiftUI
import Alamofire

struct ContentView: View {
    
    @StateObject var busRoutes: BusRoutes = BusRoutes(routes: [])
    
    var body: some View {
        NavigationStack {
            BusRoutesView()
        }.onAppear(perform: {
            Task {
                let repo = BusRepository()
                guard let response = await repo.getRoutes() else { return }
                busRoutes.routes = BusRoutes.fromDataObject(data: response).routes
            }
        }).environment(busRoutes)
    }
}

#Preview {
    ContentView().environment(BusRoutes(routes: [BusRoute(number: "151", name: "Sheridan", color: "#ff00ff")]))
}
